

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_tv/view/screen/auth/signin_screen.dart';
import 'package:provider/provider.dart';

import '../data/model/response/base/api_response.dart';
import '../provider/auth_provider.dart';


class ApiChecker {
  static void checkApi(BuildContext context, ApiResponse apiResponse) {
    //print("Error ${apiResponse.error.msg.toString()}");
    if (apiResponse.error is! String &&
        apiResponse.error == 'Unauthenticated.' ||
        apiResponse.error == 'Internal Server Error' ) {
      Provider.of<AuthProvider>(context, listen: false).clearSharredData();
       Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SigninScreen()),
          (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Session Expired! Please login again.",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red));
    } else {
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.msg;
      }
      print(_errorMessage);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_errorMessage, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red));
    }
  }
}
