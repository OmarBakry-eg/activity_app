import 'dart:convert';
import 'package:activity_app/src/utils/ui/consts.dart';
import 'package:dio/dio.dart';
import 'package:activity_app/src/core/dio/result.dart';
import 'package:activity_app/src/core/dio/un_auth_model.dart';
import 'package:activity_app/src/core/errors/logger.dart';
import 'package:activity_app/src/core/internet/internet_info.dart';
import 'dio_exception.dart';
import 'only_message_model.dart';

class DioClient {
  final InternetInfo _internetInfo;
  DioClient(this._internetInfo);

  static const String _devBaseURL = 'https://www.boredapi.com/api/activity/';

  static const Duration _duration = Duration(seconds: 10);

  final Dio _dio = Dio(BaseOptions(
      connectTimeout: _duration, // 10 seconds
      receiveTimeout: _duration // 10 seconds
      ))
    ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      logInfo(options.uri.toString());
      logInfo(options.headers.toString());
      logInfo(options.data.toString());
      return handler.next(options);
    }, onResponse: (response, handler) {
      logSuccess("RESPONSE_CODE ${response.statusCode}");
      logSuccess("RESPONSE_DATA ${response.data}");
      logSuccess('----------------------------------------------------------');
      return handler.next(response);
    }, onError: (response, handler) {
      logError(response.error.toString());
      logError("error.response.data ${response.response?.data}");
      logWarning('----------------------------------------------------------');
      return handler.next(response);
    }));

  Result _switchFunc(DioError error) {
    switch (error.response?.statusCode) {
      case 401:
        {
          UnAuthorizedModel unAuthorizedModel =
              UnAuthorizedModel.fromJson(error.response?.data);
          return Result.errorWith401(
              "${unAuthorizedModel.title}" " ${unAuthorizedModel.status}");
        }
      case 404:
      case 400:
      case 412:
        {
          var errorData = error.response?.data.runtimeType == String
              ? OnlyMessageModel.fromJson(json.decode(error.response?.data))
              : OnlyMessageModel.fromJson(error.response?.data);
          return Result.error(
              "${errorData.message} ${error.response?.statusCode}",
              statusCode: error.response?.statusCode);
        }
      default:
        {
          String errorMessage = DioExceptions.fromDioError(error).toString();
          logError("Default err case sc : ${error.response?.statusCode}");
          logError("error.message $error");
          logError("error.message2 ${error.message}");
          return Result.error(errorMessage);
        }
    }
  }

  Future<Result> get({
    String? fullURL,
    bool isLoading = false,
    bool keepLoading = false,
    bool removeErrResult = false,
  }) async {
    String url = _devBaseURL;
    bool interNetaAvailale = await _internetInfo.isConnected;
    if (isLoading) {
      Constants.showLoading();
    }
    if (interNetaAvailale) {
      try {
        Response response = await _dio.get(
          fullURL ?? url,
        );
        if (!keepLoading && isLoading) {
          Constants.hideLoading();
        }
        return Result.success(response.data);
      } on DioError catch (error) {
        if (isLoading && !keepLoading) {
          Constants.hideLoading();
        }
        return _switchFunc(error);
      }
    } else {
      if (isLoading || !keepLoading) {
        Constants.hideLoading();
      }
      return Result.networkError("No internet connection");
    }
  }
}
