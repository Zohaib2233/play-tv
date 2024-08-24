import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_tv/view/screen/mainScreen/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import '../../../data/model/response/all_channel_response_model.dart';
import '../../../provider/channel_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/custom_themes.dart';
import '../../baseWidgets/textfield/comment_textfield.dart';


class LandScapeOrientation extends StatefulWidget {
  String channelLink;
  List<AllChannelData>? allChannelData;

  LandScapeOrientation(
      {Key? key, required this.allChannelData, required this.channelLink})
      : super(key: key);

  @override
  State<LandScapeOrientation> createState() => _LandScapeOrientationState();
}

class _LandScapeOrientationState extends State<LandScapeOrientation> {
  late VideoPlayerController controller;

  @override
  void dispose() {
    controller.dispose();
    Wakelock.toggle(enable: false);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    setAllOrientation();
    super.dispose();
  }


  Future setAllOrientation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  void initState() {
  //  Provider.of<ChannelProvider>(context, listen: false).isComment = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    //to device enable while watching
    Wakelock.toggle(enable: true);
    //load video
    loadVideoPlayer();
    //set
    // setLandscape();
    super.initState();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.network(widget.channelLink);
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {
        controller.play();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller != null && controller.value.isInitialized
          ? OrientationBuilder(builder: (BuildContext context, orientation) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (Provider.of<ChannelProvider>(context, listen: false)
                                .isMenu ==
                            true) {
                          Provider.of<ChannelProvider>(context, listen: false)
                              .isMenu = false;
                        } else {
                          Provider.of<ChannelProvider>(context, listen: false)
                              .isMenu = true;
                          Future.delayed(Duration(seconds: 5), () {
                            Provider.of<ChannelProvider>(context, listen: false)
                                .isMenu = false;
                          });
                        }
                      },
                      child: buildVideo()),
                  Positioned.fill(
                    child: Stack(
                      children: [
                        // Provider.of<ChannelProvider>(context).isMenu
                        //     ?  Positioned(
                        //     top:0,
                        //     left:0,
                        //     right:0,
                        //     bottom: 0,
                        //
                        //
                        //     child: Container(color: ColorResources.BLACK.withOpacity(0.7),)):Container(),
                        Provider.of<ChannelProvider>(context).isComment
                            ? Positioned(
                                right: 50,
                                top: 50,
                                bottom: 50,
                                child: Container(
                                  width: orientation == Orientation.landscape
                                      ? 400
                                      : 150,
                                  child: ListView.builder(
                                      itemCount: 10,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Card(
                                          color: Colors.transparent,
                                          child: ListTile(
                                            leading: CircleAvatar(
                                                backgroundColor: ColorResources
                                                    .PRIMARY_COLOR),
                                            title: Text(
                                              "Name",
                                              style: robotoBold.copyWith(
                                                  color: ColorResources.WHITE),
                                            ),
                                            subtitle: Text(
                                              "Message Message Message Message Message Message Message Message",
                                              style: robotoRegular.copyWith(
                                                  color: ColorResources.WHITE),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                        );
                                      }),
                                ))
                            : Container(),
                        Provider.of<ChannelProvider>(context).isComment
                            ? Positioned(
                                right: 50,
                                bottom: 50,
                                child: Container(
                                  width: orientation == Orientation.landscape
                                      ? 400
                                      : 150,
                                  child: Container(
                                      // width: width,
                                      height: 50,
                                      child: CommentTextField(
                                        callBack: (){},
                                        boarderColor: ColorResources.WHITE,
                                        maxLine: 3,
                                        fillColor: ColorResources.PRIMARY_COLOR,
                                        hintText: "Enter Yout Comment Here",
                                      )),
                                ))
                            : Container(),

                        Provider.of<ChannelProvider>(context).isComment
                            ? Positioned(
                                right: 50,
                                top: 20,
                                child: Container(
                                  width: orientation == Orientation.landscape
                                      ? 50
                                      : 150,
                                  child: Container(
                                      // width: width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: IconButton(
                                        onPressed: () {
                                          Provider.of<ChannelProvider>(context,
                                                  listen: false)
                                              .isComment = false;
                                        },
                                        icon: Icon(Icons.close),
                                      )),
                                ))
                            : Container(),
                        Provider.of<ChannelProvider>(context).isMenu
                            ? Positioned(
                                left: 50,
                                top: 50,
                                bottom: 100,
                                child: Container(
                                    width: orientation == Orientation.landscape
                                        ? 200
                                        : 150,
                                    child: ListView.builder(
                                        itemCount:
                                            widget.allChannelData?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            color: Colors.transparent,
                                            child: ListTile(
                                              onTap: () {
                                                controller.pause();
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LandScapeOrientation(
                                                              channelLink: widget
                                                                      .allChannelData?[
                                                                          index]
                                                                      .link ??
                                                                  "",
                                                              allChannelData: widget
                                                                  .allChannelData,
                                                            )));
                                              },
                                              leading: CircleAvatar(
                                                  backgroundColor:
                                                      ColorResources
                                                          .getRedRadish(
                                                              context),
                                                  backgroundImage: NetworkImage(
                                                      widget
                                                              .allChannelData?[
                                                                  index]
                                                              .logo ??
                                                          "")),
                                              title: Text(
                                                widget.allChannelData?[index]
                                                        .name ??
                                                    "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: robotoRegular.copyWith(
                                                    color:
                                                        ColorResources.WHITE),
                                              ),
                                            ),
                                          );
                                        })))
                            : Container(),
                        Provider.of<ChannelProvider>(context).isMenu
                            ? Positioned(
                                left: 5,
                                top: 2,
                                child: Container(
                                    // color: ColorResources.getRedRadish(context),

                                    child: IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                                  },
                                  icon: Icon(Icons.arrow_back,
                                      size: 30,
                                      color: Colors.white,
                                      weight: 100),
                                )))
                            : Container(),
                        Provider.of<ChannelProvider>(context).isMenu
                            ? Positioned(
                                bottom: 10,
                                left: 5,
                                right: 0,
                                child: Row(
                                  children: [
                                    // DropdownButton<String>(
                                    //   value: selectedResolution,
                                    //   items: availableResolutions
                                    //       .map((resolution) => DropdownMenuItem(
                                    //     value: resolution,
                                    //     child: Text(resolution),
                                    //   ))
                                    //       .toList(),
                                    //   onChanged: _onResolutionSelected,
                                    // ),
                                    Icon(
                                      Icons.thumb_up,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.thumb_down,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // Provider.of<ChannelProvider>(context,
                                        //         listen: false)
                                        //     .isComment = true;
                                      },
                                      icon: Icon(
                                        Icons.chat,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.broadcast_on_home,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        //      FlutterStare.share
                                      },
                                      child: Icon(
                                        Icons.share,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        Provider.of<ChannelProvider>(context).isMenu
                            ? Positioned(
                                bottom: 65,
                                left: 5,
                                right: 0,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Colors.red,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Live",
                                      style: robotoBold.copyWith(
                                          color: Colors.red),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                        Provider.of<ChannelProvider>(context).isMenu
                            ? Positioned(
                                bottom: 50,
                                left: 0,
                                right: 0,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          child: VideoProgressIndicator(
                                        controller,
                                        allowScrubbing: true,
                                        colors: VideoProgressColors(
                                          backgroundColor: Colors.white,
                                          playedColor: Colors.red,
                                          bufferedColor: Colors.grey,
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ),
                  )
                ],
              );
            })
          : Container(
              child: Center(
              child: CircularProgressIndicator(
                color: ColorResources.PRIMARY_COLOR,
              ),
            )),
    );
  }

  Widget buildVideo() {
    return buildVideoPlayer();
  }

  Widget buildVideoPlayer() {
    print(controller.value.aspectRatio);
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller),
    );
  }
}
