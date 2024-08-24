import 'dart:convert';

import 'package:play_tv/data/model/request/manual_login_request_model.dart';
import 'package:play_tv/data/model/request/register_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/apis_end_point.dart';
import '../../util/shared_pref_keys.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/request/login_request_model.dart';
import '../model/response/base/api_response.dart';
import '../model/response/login_response_model.dart';

class AuthRepo {
  //remote
  final DioClient dioClient;
  //local
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.dioClient, required this.sharedPreferences});

  //Login function
  Future<ApiResponse> loginUser(LoginRequestModel loginRequestModel) async {
    try {
      final response = await dioClient.post(ApiEndPoints.LOGIN_API,
          data: loginRequestModel.toJson());
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  // Manual Login Function
  Future<ApiResponse> manualLoginUser(ManualLoginRequestModel manualLoginRequestModel) async {
    try {
      final response = await dioClient.post(ApiEndPoints.MANUAL_LOGIN_API,
          data: manualLoginRequestModel.toJson());
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //Register function
  Future<ApiResponse> registerUser(RegisterRequestModel requestModel) async {
    try {
      final response = await dioClient.post(ApiEndPoints.REGISTER_API,
          data: requestModel.toJson());
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //lOGOUT
  Future<bool> clearSharedData() async {
    sharedPreferences.remove(SharedPrefsKeys.IS_USER_LOGGED_IN);
    sharedPreferences.remove(SharedPrefsKeys.LOGGED_IN_USER_OBJECT);
    sharedPreferences.remove(SharedPrefsKeys.TOKEN);
    return true;
  }
  Future<ApiResponse> logout() async {
    try {
      final response = await dioClient.post(ApiEndPoints.LOGOUT_API);
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // set user token
  void setUserToken(String token) {
    sharedPreferences.setString(SharedPrefsKeys.TOKEN, token);
  }
  //set user logged in
  void setUserLoggedIn(String userJson) {
    print("My Json" + userJson);
    sharedPreferences.setBool(SharedPrefsKeys.IS_USER_LOGGED_IN, true);
    setUserObject(userJson);
  }
  void setUserObject(String userJson) {
    sharedPreferences.setString(
        SharedPrefsKeys.LOGGED_IN_USER_OBJECT, userJson);
  }

  //get user data  from "LOGGED_IN_USER_OBJECT" key
  User? getUserObject() {
    if (sharedPreferences.containsKey(SharedPrefsKeys.LOGGED_IN_USER_OBJECT)) {
      return User.fromJson(jsonDecode(
          sharedPreferences.getString(SharedPrefsKeys.LOGGED_IN_USER_OBJECT) ??
              ""));
    } else {
      return null;
    }
  }

  void updateHeader(dynamic tokenValue) {
    dioClient.updateHeader(tokenValue, "en");
  }
//check on splash is user already logged in or not
  bool isUserLoggedIn() {
    return sharedPreferences.getBool(SharedPrefsKeys.IS_USER_LOGGED_IN) == true;
  }
}