import 'package:flutter/cupertino.dart';
import 'package:play_tv/data/model/request/submit_comment_request_model.dart';
import 'package:play_tv/data/model/response/all_channel_response_model.dart';
import 'package:play_tv/data/model/response/all_comment_response_model.dart';
import 'package:play_tv/data/model/response/submit_comment_response_model.dart';
import 'package:play_tv/data/repository/channel_repo.dart';
import '../data/model/request/search_channel_request_model.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/error_response.dart';
import '../helper/api_checker.dart';

class ChannelProvider extends ChangeNotifier {
  final ChannelRepo channelRepo;
  bool _isLoading = false;
  bool _hasConnection = true;
  bool _isMenu = false;
  bool _isComment = false;
  int _tabSelected = 0;

  int get tabSelected => _tabSelected;

  set tabSelected(int value) {
    _tabSelected = value;
    notifyListeners();
  }

  bool get isComment => _isComment;

  set isComment(bool value) {
    _isComment = value;
    notifyListeners();
  }

  bool _isSearch= false;
  bool _isData= false;

  bool get isData => _isData;

  set isData(bool value) {
    _isData = value;
    notifyListeners();
  }

  bool get isSearch => _isSearch;

  set isSearch(bool value) {
    _isSearch = value;
    notifyListeners();
  }

  bool get isMenu => _isMenu;


  set isMenu(bool value) {
    _isMenu = value;
    notifyListeners();
  }

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

  ChannelProvider({required this.channelRepo});

  //get all channel
  AllChannelResponseModel? allChannelResponseModel;
  AllChannelResponseModel? allFavChannelResponseModel;
  Future<bool> getAllChannel(BuildContext context,bool isFav) async {
    _hasConnection = true;
    bool isSuccess = false;
    _isLoading = true;
   // notifyListeners();
    ApiResponse apiResponse;
    if(isFav){
       apiResponse = await channelRepo.getAllChannel(true);
    }else{
       apiResponse = await channelRepo.getAllChannel(false);
    }


    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      isSuccess = true;
      _isLoading = false;
      _isData= true;
     _isData = true;
     if(isFav){
       allFavChannelResponseModel =
           AllChannelResponseModel.fromJson(apiResponse.response?.data);
     }else{
       allChannelResponseModel =
           AllChannelResponseModel.fromJson(apiResponse.response?.data);
     }

      notifyListeners();
    } else {
      isSuccess = false;
      _isLoading = false;
      _isData= false;
      _isData = false;
      ApiChecker.checkApi(context, apiResponse);
      if (apiResponse.error.toString() ==
          'Connection to API server failed due to internet connection') {
        _hasConnection = false;
      }
    }
    notifyListeners();
    return isSuccess;
  }
//get all comment across channel id
  AllCommentResponseModel? allCommentResponseModel;
  Future<bool> getAllComment(BuildContext context,num channelId) async {
    _hasConnection = true;
    bool isSuccess = false;
    _isLoading = true;
    _isData= false;
    notifyListeners();
    ApiResponse apiResponse = await channelRepo.getAllComment(channelId);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      isSuccess = true;
      _isLoading = false;
      _isData= true;
      allCommentResponseModel = AllCommentResponseModel.fromJson(apiResponse.response?.data);
      notifyListeners();
    } else {
      isSuccess = false;
      _isLoading = false;
      _isData= false;
      _isData = false;
      ApiChecker.checkApi(context, apiResponse);
      if (apiResponse.error.toString() ==
          'Connection to API server failed due to internet connection') {
        _hasConnection = false;
      }
    }
    notifyListeners();
    return isSuccess;
  }

  //Search Channel
  Future searchChanel(String keyword,
      BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await channelRepo.searchChannel(SearchChannelRequestModel(keyword: keyword));
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      allChannelResponseModel = AllChannelResponseModel.fromJson(apiResponse.response?.data);
      _isLoading = false;
      if(allChannelResponseModel?.data?.isNotEmpty??false){
        _isData= true;
      }else{
        _isData= false;
      }

    } else {
      _isLoading = false;
      _isData= false;
      String? errorMessage;
      ApiChecker.checkApi(context, apiResponse);
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        // print(errorResponse.msg);
        //   errorMessage = '${errorResponse.code}: ${errorResponse.msg}';
      }
     // callback(false, "errorMessage");
      notifyListeners();
    }
  }



  // submitComment
  SubmitCommentResponseModel? submitCommentResponseModel;
  Future submitComment(SubmitCommentRequestModel requestModel,
      BuildContext context) async {
    _isLoading = true;
    _isData= false;
    notifyListeners();
    ApiResponse apiResponse = await channelRepo.submitComment(requestModel);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      submitCommentResponseModel = SubmitCommentResponseModel.fromJson(apiResponse.response?.data);
      _isLoading = false;
    _isData = true;

    } else {
      _isLoading = false;
      _isData= false;
      String? errorMessage;
      ApiChecker.checkApi(context, apiResponse);
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        // print(errorResponse.msg);
        //   errorMessage = '${errorResponse.code}: ${errorResponse.msg}';
      }
      // callback(false, "errorMessage");
      notifyListeners();
    }
  }

}