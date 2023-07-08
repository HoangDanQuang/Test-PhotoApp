import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_intesco/commons/connections/dio_client.dart';

class PhotoRepository {
  final DioClient _dioClient = DioClient(Dio());

  Future<dynamic> getPhotos({pageSize = 20, pageNumber = 1}) async {
    try {
      final res = await _dioClient.get(
        'https://photoslibrary.googleapis.com/v1/mediaItems' 
            + '?pageSize=$pageSize',
      );
      return res;
    } on DioError catch (e) {
      print('getPhotos error');
      throw e;
    }
  }

  Future<dynamic> uploadPhoto(File file) async {
    try {
      String fileName = file.path.split('/').last;
      String fileType = fileName.split('.').last;
      Options options = Options(
        headers: {
          'X-Goog-Upload-Content-Type': 'image/$fileType',
          'X-Goog-Upload-Protocol': 'raw'
        }
      );     
      final res = await _dioClient.post(
        'https://photoslibrary.googleapis.com/v1/uploads',
        contentType: 'application/octet-stream',
        options: options,
        data: file.readAsBytesSync(),
      );
      print('@@ res: $res');
      final res2 = await _dioClient.post(
        'https://photoslibrary.googleapis.com/v1/mediaItems:batchCreate',
        data: jsonEncode({
          "newMediaItems": [
            {
              "description": "",
              "simpleMediaItem": {
                "fileName": fileName,
                "uploadToken": res,
              }
            }
          ]
        }),
      );
      return res2;
    } on DioError catch (e) {
      print('uploadPhoto error');
      throw e;
    }
  }


}