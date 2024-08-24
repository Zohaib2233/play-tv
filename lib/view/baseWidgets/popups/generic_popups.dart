import 'package:flutter/material.dart';

import '../../../util/color_resources.dart';


Future playTvAlertDialog(BuildContext context,
    { String? title,
    Function? action1Function,
    String? action1Text,
    Function? action2Function,
    String? action2Text}) async {
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          contentPadding: EdgeInsets.symmetric(vertical: 14.0),
          title: Text(
            title??"",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  action1Function == null
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            action1Function();
                          },
                          child: action1Text != null
                              ? Text(
                                  action1Text,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 18.0),
                                )
                              : Container()),
                  action2Function != null
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            action2Function();
                          },
                          child: action2Text != null
                              ? Text(
                                  action2Text,
                                  style: TextStyle(
                                      color: ColorResources.COLOR_PRIMARY,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                )
                              : Container(),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        );
      });
}
