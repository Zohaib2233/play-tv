import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:play_tv/provider/channel_provider.dart';
import 'package:play_tv/util/color_resources.dart';
import 'package:play_tv/util/custom_themes.dart';
import 'package:play_tv/view/screen/channelDetail/landscape_orientation_screen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_controller.dart';

import '../../../localization/language_constrants.dart';
import '../../../util/images.dart';
import '../../baseWidgets/button/channel_button.dart';
import '../../baseWidgets/noData/noData.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set<FocusNode> itemFocusNodes = Set<FocusNode>();
  int currentFocusedIndex = 0;

  @override
  void initState() {
    Provider.of<ChannelProvider>(context, listen: false)
        .getAllChannel(context, true);
    var itemCount = Provider.of<ChannelProvider>(context, listen: false)
            .allFavChannelResponseModel
            ?.data
            ?.length ??
        0;
// Generate FocusNodes and add them to the set
    for (int i = 0; i < itemCount; i++) {
      itemFocusNodes.add(FocusNode());
    }
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

  int activeIndex = 0;
  final controller = CarouselController();
  final images = [
    Images.banner_image_1,
    Images.banner_image_2,
    Images.banner_image_3
  ];

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;
    Size screenSize = MediaQuery.of(context).size;
    bool isLandscape = orientation == Orientation.landscape;
    var channelData =
        Provider.of<ChannelProvider>(context).allFavChannelResponseModel;

    return Column(
      children: [
        Provider.of<ChannelProvider>(context).isSearch
            ? TextField(
                maxLines: 1,
                onChanged: (keyword) {
                  if (keyword.length > 1) {
                    Provider.of<ChannelProvider>(context, listen: false)
                        .searchChanel(keyword, context);
                  }

                  if (keyword.isEmpty) {
                    Provider.of<ChannelProvider>(context, listen: false)
                        .getAllChannel(context, true);
                  }
                },
                style: robotoRegular.copyWith(color: Colors.white),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.03),
                        borderSide: BorderSide(
                          color: ColorResources.WHITE,
                        )),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: getTranslated("ENTER_CHANNEL_NAME", context),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.03),
                        borderSide: BorderSide(
                          color: ColorResources.WHITE,
                        ))),
              )
            : Container(),
        // SizedBox(height: 10,),
        Container(
          height: isLandscape ? height * 0.4 : height * 0.3,
          width: width,
          child: CarouselSlider.builder(
              carouselController: controller,
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                final image = images[index];
                return buildImage(image, index);
              },
              options: CarouselOptions(
                  //    height: height*0.45,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(seconds: 3),
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index))),
        ),
        SizedBox(height: 12),
        buildIndicator(),
        SizedBox(
          height: 10,
        ),
        Provider.of<ChannelProvider>(context).isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: ColorResources.PRIMARY_COLOR,
              ))
            : Provider.of<ChannelProvider>(context).isData
                ? Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RawKeyboardListener(
                          focusNode: FocusNode(),
                          autofocus: true,
                          onKey: (RawKeyEvent event) {
                            if (event is RawKeyDownEvent) {
                              print(event.logicalKey);
                              if (event.logicalKey ==
                                  LogicalKeyboardKey.arrowRight) {
                                // Move focus to the next item to the right
                                if (currentFocusedIndex <
                                    (channelData?.data?.length ?? 0) - 1) {
                                  // itemFocusNodes
                                  //     .elementAt(currentFocusedIndex)
                                  //     .unfocus();
                                  currentFocusedIndex++;
                                  itemFocusNodes
                                      .elementAt(currentFocusedIndex)
                                      .requestFocus();
                                  setState(() {

                                  });
                                  print(currentFocusedIndex);
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
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 2.5,
                                  crossAxisSpacing: 20,
                                ),
                                itemCount: channelData?.data?.length ?? 0,
                                itemBuilder: (BuildContext context, index) {
                                  return Focus(
                                    focusNode: itemFocusNodes.elementAt(index),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LandScapeOrientation(
                                                        channelLink: channelData
                                                                ?.data?[index]
                                                                .link ??
                                                            "",
                                                        allChannelData:
                                                            channelData?.data ??
                                                                [],
                                                      )));
                                        },
                                        child: ChannelButton(
                                          channelText:
                                              channelData?.data?[index].name ??
                                                  "",
                                          channelImage:
                                              channelData?.data?[index].logo ??
                                                  "",
                                          isFocus: itemFocusNodes
                                                  .elementAt(index)
                                                  .hasFocus
                                              ? true
                                              : false,
                                        )),
                                  );
                                }),
                          ),
                        )),
                  )
                : Expanded(
                    child: Container(child: Center(child: NoData())),
                  )
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: SlideEffect(dotWidth: 15, activeDotColor: Colors.blue),
        activeIndex: activeIndex,
        count: images.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}
