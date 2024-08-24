import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_tv/view/screen/channelDetail/landscape_orientation_screen.dart';
import 'package:provider/provider.dart';
import '../../../provider/channel_provider.dart';
import '../../../util/color_resources.dart';


class AllChannelScreen extends StatefulWidget {
  @override
  State<AllChannelScreen> createState() => _AllChannelScreenState();
}

class _AllChannelScreenState extends State<AllChannelScreen> {
  Set<FocusNode> itemFocusNodes = Set<FocusNode>();
  int currentFocusedIndex = 0;
  void initState() {
    Provider.of<ChannelProvider>(context, listen: false).getAllChannel(context,false);
    var itemCount = Provider.of<ChannelProvider>(context, listen: false).allChannelResponseModel
        ?.data
        ?.length ??0;
    print(itemCount);
    // Generate FocusNodes and add them to the set
    for (int i = 0; i < itemCount; i++) {
    itemFocusNodes.add(FocusNode());
    }
    print(itemFocusNodes.length);
    // // Set focus on the first item initially
    // itemFocusNodes.elementAt(0).requestFocus();
    super.initState();
  }
  @override
  void dispose() {
    // Dispose of the FocusNode list in the dispose method to prevent memory leaks
    for (var node in itemFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  //Function to get index of current focus node
  int? getCurrentFocusedItemIndex() {
    // Iterate through the list of FocusNodes and find the index of the focused one
    for (int index = 0; index < itemFocusNodes.length; index++) {
      if (itemFocusNodes.elementAt(index).hasFocus) {
        return index; // Return the index of the focused item
      }
    }
    return null; // Return null if no item is currently focused
  }

  @override
  Widget build(BuildContext context) {
    var channelData =
        Provider.of<ChannelProvider>(context).allChannelResponseModel;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Provider.of<ChannelProvider>(context).isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: ColorResources.PRIMARY_COLOR,
            ))
          : Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      autofocus: true,
                      onKey: (RawKeyEvent event) {
                        if (event is RawKeyDownEvent) {
                          print(event.logicalKey);
                          if (event.logicalKey ==
                              LogicalKeyboardKey.arrowRight) {
                            print(itemFocusNodes
                                .elementAt(currentFocusedIndex));
                            // Move focus to the next item to the right
                            if (currentFocusedIndex <
                                (channelData?.data?.length ?? 0) - 1) {
                              print("1");
                              // itemFocusNodes
                              //     .elementAt(currentFocusedIndex)
                              //     .unfocus();
                              currentFocusedIndex++;
                              itemFocusNodes
                                  .elementAt(currentFocusedIndex)
                                  .requestFocus();
                              setState(() {

                              });
print(currentFocusedIndex  );
                              print(itemFocusNodes
                                  .elementAt(currentFocusedIndex).hasFocus);
                            }
                          } else if (event.logicalKey ==
                              LogicalKeyboardKey.arrowLeft) {
                            // Move focus to the previous item to the left
                            if (currentFocusedIndex > 0) {
                              itemFocusNodes
                                  .elementAt(currentFocusedIndex)
                                  .unfocus();
                              currentFocusedIndex--;
                              itemFocusNodes
                                  .elementAt(currentFocusedIndex)
                                  .requestFocus();
                              setState(() {

                              });
                            }
                          } else if (event.logicalKey ==
                              LogicalKeyboardKey.enter) {
                            print(getCurrentFocusedItemIndex());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LandScapeOrientation(
                                          channelLink: channelData
                                              ?.data?[
                                          getCurrentFocusedItemIndex()??0]
                                              .link ??
                                              "",
                                          allChannelData:
                                          channelData?.data ?? [],
                                        )));

                          }
                        }
                      },
                      child: FocusScope(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                constraints.maxWidth > 600 ? 100 : 150,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: channelData?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Focus(
                              focusNode:  itemFocusNodes.elementAt(index),
                              child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:itemFocusNodes
                                        .elementAt(index)
                                        .hasFocus? ColorResources.PRIMARY_COLOR:Colors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.network(
                                    channelData?.data?[index].logo ?? "",
                                    fit: BoxFit.contain,
                                    color:itemFocusNodes
                                        .elementAt(index)
                                        .hasFocus? ColorResources.PRIMARY_COLOR:null,

                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LandScapeOrientation(
                                              channelLink:
                                                  channelData?.data?[index].link ??
                                                      "",allChannelData: channelData?.data??[],)));

                                  print(index);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
