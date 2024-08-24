import 'dart:convert';

import 'package:play_tv/data/model/request/search_channel_request_model.dart';
import 'package:play_tv/data/model/request/submit_comment_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/apis_end_point.dart';
import '../../util/shared_pref_keys.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/request/login_request_model.dart';
import '../model/response/base/api_response.dart';
import '../model/response/login_response_model.dart';

class ChannelRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  ChannelRepo({required this.dioClient, required this.sharedPreferences});

  //Get Fav and all Channel
  Future<ApiResponse> getAllChannel(bool isFav) async {
    try {
      final response;
      if (isFav) {
        response = await dioClient.get(ApiEndPoints.GET_FAV_CHANNEL_API);
      } else {
        response = await dioClient.get(ApiEndPoints.GET_ALL_CHANNEL_API);
      }

      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //Get all comment
  Future<ApiResponse> getAllComment(num channelId) async {
    try {
      final response = await dioClient
          .get(ApiEndPoints.GET_ALL_COMMENT_API + "/$channelId");
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //Search Channel
  Future<ApiResponse> searchChannel(SearchChannelRequestModel request) async {
    try {
      final response =
          await dioClient.post(ApiEndPoints.SEARCH_API, data: request);
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  //submitComment
  Future<ApiResponse> submitComment(SubmitCommentRequestModel request) async {
    try {
      final response =
      await dioClient.post(ApiEndPoints.SUBMIT_COMMENT, data: request);
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
