import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:play_tv/provider/channel_provider.dart';
import 'package:play_tv/util/custom_themes.dart';
import 'package:play_tv/view/screen/auth/signin_screen.dart';

import 'package:provider/provider.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/images.dart';
import '../../baseWidgets/popups/generic_popups.dart';
import '../tabs/home.dart';
import '../tabs/tv_live_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  @override
  late TabController _controller;
  FocusNode homeTabFocusNode = FocusNode();
  FocusNode tvLiveTabFocusNode = FocusNode();
  FocusNode logOutFocusNode = FocusNode();

@override
  void dispose() {
  homeTabFocusNode.dispose();
  tvLiveTabFocusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void initState() {
    // Provider.of<ChannelProvider>(context, listen: false).isSearch = false;

    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      Provider.of<ChannelProvider>(context, listen: false).tabSelected =
          _controller.index;
    });
    homeTabFocusNode.requestFocus();
    super.initState();
  }

  int _selectedIndex = 0;

  void _logout() {
    Provider.of<AuthProvider>(context, listen: false).logout(
        (bool status, String msg) {
      if (status) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(msg, style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SigninScreen()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Something went Wrong",
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red));
      }
    }, context);
  }

  static List<Widget> screens = <Widget>[
    HomeScreen(),
    AllChannelScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;
    bool isLandscape = orientation == Orientation.landscape;

    return DefaultTabController(
      length: 2,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              // Move the TabBar selection to the left.
              print(tvLiveTabFocusNode.hasFocus);
              if(tvLiveTabFocusNode.hasFocus){
                homeTabFocusNode.requestFocus();
                _controller.animateTo(_controller.index - 1);

              }

            } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              // Move the TabBar selection to the right.
              print(homeTabFocusNode.hasFocus);
              if(homeTabFocusNode.hasFocus){
                tvLiveTabFocusNode.requestFocus();
                _controller.animateTo(_controller.index + 1);

              }

            }else if(event.logicalKey == LogicalKeyboardKey.arrowUp){
              print("logout");
              if(homeTabFocusNode.hasFocus || tvLiveTabFocusNode.hasFocus){
                print("L 1");
                logOutFocusNode.requestFocus();
              }else{
                homeTabFocusNode.requestFocus();
              }
            }else if(event.logicalKey == LogicalKeyboardKey.arrowDown){
              if(homeTabFocusNode.hasFocus || tvLiveTabFocusNode.hasFocus){
                print("L 2");
                FocusManager.instance.primaryFocus?.nextFocus();
              }else if(logOutFocusNode.hasFocus){
                print("arrow down");
                //
                // homeTabFocusNode.requestFocus();
                // _controller.animateTo(_controller.index-1);
              }
            }
            else if(event.logicalKey == LogicalKeyboardKey.select){
              _logout();
            }
          }
        },
        child: Scaffold(
          backgroundColor: ColorResources.getDeepForestBrown(context),
          appBar: AppBar(
            bottom: isLandscape
                ? TabBar(
                    controller: _controller,
                    onTap: (value) {
                      Provider.of<ChannelProvider>(context, listen: false)
                          .tabSelected = value;
                    },
                    indicator: null,
                    indicatorColor: ColorResources.getDeepForestBrown(context),
                    tabs: [
                      Focus(
                        focusNode: homeTabFocusNode,
                        child: Tab(
                          child: Container(
                            width: width * 0.5,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Provider.of<ChannelProvider>(context)
                                            .tabSelected ==
                                        0
                                    ? ColorResources.PRIMARY_COLOR
                                    : ColorResources.WHITE,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "HOME",
                              style: robotoRegular.copyWith(
                                  fontSize: 12.5,
                                  color: Provider.of<ChannelProvider>(context)
                                              .tabSelected ==
                                          0
                                      ? ColorResources.WHITE
                                      : ColorResources.BLACK),
                            ),
                          ),
                        ),
                      ),
                      Focus(
                        focusNode: tvLiveTabFocusNode,
                        child: Tab(
                          child: Container(
                            width: width * 0.5,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Provider.of<ChannelProvider>(context)
                                            .tabSelected ==
                                        1
                                    ? ColorResources.PRIMARY_COLOR
                                    : ColorResources.WHITE,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "TV LIVE",
                              style: robotoRegular.copyWith(
                                  fontSize: 12.5,
                                  color: _controller.index == 1
                                      ? ColorResources.WHITE
                                      : ColorResources.BLACK),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Image.asset(
              Images.tv_logo_png,
              width: width * 0.2,
              height: height * 0.08,
            ),
            actions: [
              // Provider.of<ChannelProvider>(context).isSearch
              //     ? IconButton(
              //         onPressed: () async {
              //           Provider.of<ChannelProvider>(context, listen: false)
              //               .isSearch = false;
              //         },
              //         icon: Icon(Icons.close_rounded))
              //     : IconButton(
              //         onPressed: () async {
              //           Provider.of<ChannelProvider>(context, listen: false)
              //               .isSearch = true;
              //         },
              //         icon: Icon(Icons.search_outlined)),
              IconButton(
                focusNode: logOutFocusNode,
                  onPressed: () async {
                    await playTvAlertDialog(context,
                        title: "Do you want to logout?",
                        action1Function: () {},
                        action1Text: "No", action2Function: () {
                      _logout();
                    }, action2Text: "Yes");
                  },
                  icon: Icon(Icons.logout)),
            ],
          ),
          body: Provider.of<AuthProvider>(context).isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: isLandscape
                            ? TabBarView(controller: _controller, children: [
                                HomeScreen(),
                                AllChannelScreen(),
                              ])
                            : screens[_selectedIndex])
                  ],
                ),
          bottomNavigationBar: isLandscape
              ? null
              : BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: ColorResources.PRIMARY_COLOR,
                  selectedItemColor: ColorResources.WHITE,
                  unselectedItemColor: ColorResources.BLACK,
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.live_tv), label: "TV Live"),
                  ],
                ),
        ),
      ),
    );
  }
}
