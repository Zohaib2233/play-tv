import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_tv/data/model/request/submit_comment_request_model.dart';
import 'package:play_tv/localization/language_constrants.dart';
import 'package:play_tv/provider/channel_provider.dart';
import 'package:play_tv/util/color_resources.dart';
import 'package:play_tv/util/custom_themes.dart';
import 'package:play_tv/view/baseWidgets/textfield/comment_textfield.dart';

import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import '../../../data/model/response/all_channel_response_model.dart';
import '../../baseWidgets/customScaffoldMessenger.dart';
import '../mainScreen/main_screen.dart';
import 'landscape_orientation_screen.dart';

class BothLandscapePortraitScreen extends StatefulWidget {
  String channelLink;
  num? channelId;
  List<AllChannelData>? allChannelData;

  BothLandscapePortraitScreen(
      {Key? key,
      required this.channelLink,
      this.allChannelData,
      this.channelId})
      : super(key: key);

  @override
  State<BothLandscapePortraitScreen> createState() =>
      _BothLandscapePortraitScreenState();
}

class _BothLandscapePortraitScreenState extends State<BothLandscapePortraitScreen> {
  late VideoPlayerController controller;
  bool enable = true;
  TextEditingController _commentText = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _validate() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      String commentText = _commentText.text.trim();
      if (commentText.isEmpty) {
        showSnackNotification(
            context: context, isError: true, "Please write your comment");
      } else if (commentText.length < 5) {
        showSnackNotification(
            context: context,
            isError: true,
            "Comment should be more than 5 characters");
      } else {
        _commentText.clear();
        FocusScope.of(context).unfocus();
        SubmitCommentRequestModel requestModel = SubmitCommentRequestModel(
          isLike: "0",
          isDislike: "0",
          comments: commentText,
          channelId: widget.channelId.toString() ?? "",
        );
        Provider.of<ChannelProvider>(context, listen: false)
            .submitComment(requestModel, context);
      }
    }
  }

  @override
  void initState() {
    //to device enable while watching
    Wakelock.toggle(enable: true);
    //load video
    loadVideoPlayer();
    //Load comments
    Provider.of<ChannelProvider>(context, listen: false)
        .getAllComment(context, widget.channelId ?? 0);
    print(Provider.of<ChannelProvider>(context, listen: false)
        .allCommentResponseModel
        ?.allComments
        ?.length);
    super.initState();
  }

  void dispose() {
    controller.dispose();
    Wakelock.toggle(enable: false);
    setAllOrientation();
    super.dispose();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.network(
      widget.channelLink,
    );
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {
        controller.play();
      });
    });
  }

  Future setAllOrientation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var height = MediaQuery.of(context).size.height;
    var commentData =
        Provider.of<ChannelProvider>(context).allCommentResponseModel;
    return Scaffold(
      appBar: isPortrait
          ? AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              backgroundColor: ColorResources.PRIMARY_COLOR,
            )
          : null,
      backgroundColor: ColorResources.getDeepForestBrown(context),
      body: Form(
        key: _formKey,
        child: Container(
          width: width,
          height: height,
          child: Stack(
            children: [
              controller != null && controller.value.isInitialized
                  ? OrientationBuilder(
                      builder: (BuildContext context, orientation) {
                        Orientation orientation =
                            MediaQuery.of(context).orientation;
                        return Stack(
                          // fit:orientation == Orientation.landscape?StackFit.expand:StackFit.loose ,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (Provider.of<ChannelProvider>(context,
                                            listen: false)
                                        .isMenu ==
                                    true) {
                                  Provider.of<ChannelProvider>(context,
                                          listen: false)
                                      .isMenu = false;
                                } else {
                                  Provider.of<ChannelProvider>(context,
                                          listen: false)
                                      .isMenu = true;
                                  Future.delayed(Duration(seconds: 5), () {
                                    Provider.of<ChannelProvider>(context,
                                            listen: false)
                                        .isMenu = false;
                                  });
                                }
                              },
                              child: Container(
                                  height: orientation == Orientation.landscape
                                      ? height
                                      : height * 0.35,
                                  child: buildVideo()),
                            ),
                            Positioned.fill(
                              child: Stack(
                                children: [
                                  Provider.of<ChannelProvider>(context).isMenu
                                      ? Positioned(
                                          left: 5,
                                          top: 10,
                                          bottom: 30,
                                          child: Container(
                                              width: orientation ==
                                                      Orientation.landscape
                                                  ? 200
                                                  : 150,
                                              child: ListView.builder(
                                                  itemCount: widget
                                                          .allChannelData
                                                          ?.length ??
                                                      0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Card(
                                                      child: ListTile(
                                                        onTap: () {
                                                          controller.pause();
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          BothLandscapePortraitScreen(
                                                                            channelLink:
                                                                                widget.allChannelData?[index].link ?? "",
                                                                            allChannelData:
                                                                                widget.allChannelData,
                                                                          )));
                                                        },
                                                        leading: CircleAvatar(
                                                            backgroundColor:
                                                                ColorResources
                                                                    .getRedRadish(
                                                                        context),
                                                            backgroundImage:
                                                                NetworkImage(widget
                                                                        .allChannelData?[
                                                                            index]
                                                                        .logo ??
                                                                    "")),
                                                        title: Text(
                                                          widget
                                                                  .allChannelData?[
                                                                      index]
                                                                  .name ??
                                                              "",
                                                          style: robotoRegular,
                                                        ),
                                                      ),
                                                    );
                                                  })))
                                      : Container(),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              if (controller.value.isPlaying) {
                                                controller.pause();
                                                Wakelock.toggle(enable: false);
                                              } else {
                                                controller.play();
                                              }
                                              setState(() {});
                                            },
                                            icon: Icon(
                                              controller.value.isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              color: Colors.white,
                                            )),
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
                                        IconButton(
                                            onPressed: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LandScapeOrientation(
                                                              allChannelData: widget
                                                                  .allChannelData,
                                                              channelLink: widget
                                                                  .channelLink)));
                                              print(orientation);
                                              // if (orientation ==
                                              //     Orientation.portrait) {
                                              //   SystemChrome
                                              //       .setPreferredOrientations([
                                              //     DeviceOrientation.landscapeLeft,
                                              //     DeviceOrientation
                                              //         .landscapeRight,
                                              //   ]);
                                              // } else if (orientation ==
                                              //     Orientation.landscape) {
                                              //   SystemChrome
                                              //       .setPreferredOrientations([
                                              //     DeviceOrientation.portraitUp,
                                              //     DeviceOrientation.portraitDown,
                                              //   ]);
                                              // }
                                              //    setState(() {});
                                            },
                                            icon: Icon(
                                              Icons.fullscreen,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    )
                  : Container(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ColorResources.PRIMARY_COLOR,
                        ),
                      )),
              isPortrait
                  ? Positioned(
                      top: height * 0.35,
                      left: 0,
                      right: 0,
                      child: commentData?.allComments?.length == null
                          ? Container(
                              width: width,
                              height: height * 0.46,
                              child: Center(
                                child: Text(
                                  "No Comment yet",
                                  style: robotoBold.copyWith(
                                      color: ColorResources.WHITE),
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                            child: Container(
                                width: width,
                                height: height * 0.46,
                                child: ListView.builder(
                                    itemCount:
                                        commentData?.allComments?.length ?? 0,
                                    itemBuilder: (context, index)
                                    {
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor:
                                              ColorResources.PRIMARY_COLOR,
                                          backgroundImage: NetworkImage(
                                              commentData?.allComments?[index]
                                                      .image ??
                                                  ""),
                                        ),
                                        title: Text(
                                          commentData?.allComments?[index].name ??
                                              "",
                                          style: robotoBold.copyWith(
                                              color: ColorResources.WHITE),
                                        ),
                                        subtitle: Text(
                                          commentData
                                                  ?.allComments?[index].comment ??
                                              "",
                                          style: robotoRegular.copyWith(
                                              color: ColorResources.WHITE),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      );
                                    }),
                              ),
                          ))
                  : Container(),
              isPortrait
                  ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          width: width,
                          height: height * 0.08,
                          child: CommentTextField(
                            controller: _commentText,
                            callBack: () async {
                              await _validate();

                            },
                            boarderColor: ColorResources.WHITE,
                            maxLine: 3,
                            fillColor: ColorResources.PRIMARY_COLOR,
                            hintText: "Enter Your Comment Here",
                          )))
                  : Container(),
            ],
          ),
        ),
      ),
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
