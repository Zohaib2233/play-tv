import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../localization/language_constrants.dart';
import '../../../util/color_resources.dart';
import '../../../util/custom_themes.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';

class NoInternetOrDataScreen extends StatelessWidget {
  final bool isNoInternet;
  final Widget child;

  NoInternetOrDataScreen({required this.isNoInternet, required this.child});

  FocusNode _retryFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: Center(
          child: RawKeyboardListener(
            focusNode: FocusNode(),
            autofocus: true,
            onKey: (RawKeyEvent event) {
              print("hassan+${event.logicalKey}");
              if (event is RawKeyDownEvent) {
                if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                  print("arrow down");
                  if (_retryFocusNode.hasFocus) {
                    if (Connectivity().checkConnectivity() !=
                        ConnectivityResult.none) {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => child));
                    }
                  } else {
                    print("5");
                    _retryFocusNode.requestFocus();
                  }
                } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                  if (_retryFocusNode.hasFocus) {
                    if (Connectivity().checkConnectivity() !=
                        ConnectivityResult.none) {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => child));
                    }
                  } else {
                    print("5");
                    _retryFocusNode.requestFocus();
                  }
                } else if (event.logicalKey == LogicalKeyboardKey.select) {
                  print("enter");
                  // Handle Enter key press (e.g., trigger login or register)
                  if (_retryFocusNode.hasFocus) {
                    if (Connectivity().checkConnectivity() !=
                        ConnectivityResult.none) {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => child));
                    }
                  } else {
                    _retryFocusNode.requestFocus();
                  }
                }
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    isNoInternet ? Images.no_internet : Images.no_data),
                Text(isNoInternet ? "OPPS" : "SORRY",
                    style: robotoRegular.copyWith(
                      fontSize: 30,
                      color: isNoInternet
                          ? Theme.of(context).textTheme.bodyText1?.color
                          : ColorResources.COLOR_PRIMARY,
                    )),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Text(
                  isNoInternet ? "No Internet Connection" : 'No data found',
                  textAlign: TextAlign.center,
                  style: robotoRegular,
                ),
                SizedBox(height: 40),
                isNoInternet
                    ? Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ColorResources.COLOR_PRIMARY,
                        ),
                        child: TextButton(
                          focusNode: _retryFocusNode,
                          onPressed: () async {
                            if (await Connectivity().checkConnectivity() !=
                                ConnectivityResult.none) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) => child));
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text("Retry",
                                style: robotoBold.copyWith(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: Dimensions.FONT_SIZE_LARGE)),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
