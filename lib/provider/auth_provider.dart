import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:play_tv/data/model/request/manual_login_request_model.dart';
import 'package:play_tv/data/model/request/register_request_model.dart';
import 'package:play_tv/data/model/response/login_response_model.dart';
import 'package:play_tv/data/model/response/register_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/request/login_request_model.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/error_response.dart';
import '../data/model/response/manual_login_response_model.dart';
import '../data/repository/auth_repo.dart';
import '../helper/api_checker.dart';
import '../localization/language_constrants.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo authRepo;
  bool _isLoading = false;
  bool _isLoginLoading = false;
  bool _isRegisterLoading = false;

  bool get isRegisterLoading => _isRegisterLoading;

  set isRegisterLoading(bool value) {
    _isRegisterLoading = value;
    notifyListeners();
  }

  bool get isLoginLoading => _isLoginLoading;

  set isLoginLoading(bool value) {
    _isLoginLoading = value;
    notifyListeners();
  }

  bool _hasConnection = true;

  bool get hasConnection => _hasConnection;

  set hasConnection(bool value) {
    _hasConnection = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  AuthProvider({required this.authRepo});

  //Login function
 LoginResponseModel? loginResponseModel;
  Future login(LoginRequestModel loginRequestModel, Function callback,
      BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.loginUser(loginRequestModel);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      loginResponseModel = LoginResponseModel.fromJson(apiResponse.response?.data);
      _isLoading = false;
      User? user = loginResponseModel?.data;
       String jsonUser = jsonEncode(user); // json encoding user for saving in sharedPref

      if (loginResponseModel?.data?.isActive == "Y") {
        authRepo.setUserLoggedIn(jsonUser ?? "");
        print(authRepo.getUserObject());
        authRepo.setUserToken(loginResponseModel?.data?.tokenId ?? "");
        authRepo.updateHeader(loginResponseModel?.data?.tokenId);
        callback(true, getTranslated("LOGIN_SUCCESSFULLY", context));
        notifyListeners();
      }
    } else {
      _isLoading = false;
      String? errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
        callback(false, errorMessage);
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }

      notifyListeners();
    }
  }

  //Manual Login function
  ManualLoginResponseModel?  manualLoginResponseModel;
  Future manualLogin(ManualLoginRequestModel manualLoginRequestModel, Function callback,
      BuildContext context) async {
    _isLoginLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.manualLoginUser(manualLoginRequestModel);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      manualLoginResponseModel = ManualLoginResponseModel.fromJson(apiResponse.response?.data);
      _isLoginLoading = false;
      User? user = manualLoginResponseModel?.data;
      String jsonUser = jsonEncode(user); // json encoding user for saving in sharedPref

      if (manualLoginResponseModel?.data?.isActive == "Y") {
        authRepo.setUserLoggedIn(jsonUser ?? "");
        print(authRepo.getUserObject());
        authRepo.setUserToken(manualLoginResponseModel?.data?.tokenId ?? "");
        authRepo.updateHeader(manualLoginResponseModel?.data?.tokenId);
        callback(true, getTranslated("LOGIN_SUCCESSFULLY", context));
        notifyListeners();
      }
    } else {
      _isLoginLoading = false;
      String? errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
        callback(false, errorMessage);
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

  //Register Function
RegisterResponseModel? registerResponseModel;
  Future register(RegisterRequestModel requestModel, Function callback,
      BuildContext context) async {
    _isRegisterLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.registerUser(requestModel);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      registerResponseModel = RegisterResponseModel.fromJson(apiResponse.response?.data);
      _isRegisterLoading = false;
      callback(true,registerResponseModel?.msg??"");
      notifyListeners();
    } else {
      _isRegisterLoading = false;
      String? errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
        callback(context,errorMessage);
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

  //Logout function
  Future logout(Function callback,
      BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.logout();
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      await clearSharredData();
      callback(true, getTranslated("LOGOUT_SUCCESSFULLY", context));
      _isLoading = false;
    } else {
      _isLoading = false;
      String? errorMessage;
      ApiChecker.checkApi(context, apiResponse);
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
        callback(context,errorMessage);
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

  bool isUserLoggedIn() {
    return authRepo.isUserLoggedIn();
  }

  Future<bool> clearSharredData() {
    return authRepo.clearSharedData();
  }

}