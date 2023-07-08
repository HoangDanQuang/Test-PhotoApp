import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_intesco/commons/services/shared_preference_helper.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  Future<dynamic> header({String? contentType}) async {
    SharedPreferenceHelper _sharedPreference =
        SharedPreferenceHelper(await SharedPreferences.getInstance());

    Map<String, String> headers = {};
    String? token = await _sharedPreference.authToken;

    if (token != null) {
      headers = {
        'authorization': 'Bearer $token',
        'Content-Type': contentType ?? 'application/json',
      };
    } else {
      headers = {
        'Content-Type': contentType ?? 'application/json',
      };
    }

    return headers;
  }

  // Future<dynamic> refreshToken() async {

  // }

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    String? contentType,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var optionHeader = options != null ? options.headers : {};
      var authorization = await header(contentType: contentType);
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: Options(
          headers: {...authorization, ...?optionHeader},
        ),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
      print('dio GET');
      print(uri);
      // print(queryParameters);
      print(response.data);
      print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
      return response.data;
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        
      }
      throw e;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    String? contentType,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    var optionHeader = options?.headers;
    var authorization = await header(contentType: contentType);
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {...authorization, ...?optionHeader},
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
      print('dio POST');
      print(uri);
      print(data);
      print(response.data);
      print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
      return response.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {

      }
      throw e;
    }
  }

  
}
