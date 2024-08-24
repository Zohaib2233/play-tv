import 'dart:async';
import 'package:flutter/material.dart';
import 'package:play_tv/provider/auth_provider.dart';
import 'package:play_tv/util/color_resources.dart';
import 'package:play_tv/util/images.dart';
import 'package:play_tv/view/screen/auth/signin_screen.dart';
import 'package:provider/provider.dart';

import '../../../helper/network_info.dart';
import '../../baseWidgets/noInternetConnection/no_internet_screen.dart';
import '../mainScreen/main_screen.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState()  {
    _getAppConfiguration();
    super.initState();
  }

  Future<void> _getAppConfiguration() async {
    Timer(Duration(seconds: 1),() async {
      final isUserLoggedIn =
      Provider.of<AuthProvider>(context, listen: false).isUserLoggedIn();
      if (await NetworkInfo.isInternet()) {
      isUserLoggedIn ? _openHomeScreen(context) : _openLoginScreen(context);
      } else {
      Provider.of<AuthProvider>(context, listen: false).hasConnection = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("You are not connected to internet",
      style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.red));
      }
    });



  }

  void _openLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => SigninScreen()));
  }

  void _openHomeScreen(BuildContext context) {

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:Provider.of<AuthProvider>(context, listen: true).hasConnection
          ? Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: null,
              color: ColorResources.getDeepForestBrown(context),
              // image: DecorationImage(
              //   image: AssetImage(Images.tv_logo_png),
              //   fit: BoxFit.contain,
              // ),
            ),
            child: Center(
                child:
                Image.asset(Images.tv_logo_png)) /* add child content here */,
          ),
          Positioned(
              bottom: height * 0.1,
              left: width * 0.45,
              child:  CircularProgressIndicator(color: ColorResources.PRIMARY_COLOR,)
                  )
        ],
      ) :NoInternetOrDataScreen(
        isNoInternet: true,
        child: SplashScreen(),
      ),
    );
  }
}
