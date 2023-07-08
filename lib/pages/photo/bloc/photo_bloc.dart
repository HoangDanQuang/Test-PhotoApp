import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:test_intesco/commons/base_bloc.dart';
import 'package:test_intesco/commons/modals/photo_item.dart';
import 'package:test_intesco/commons/utils/datetime_utils.dart';
import 'package:test_intesco/repositories/photo/photo_repository.dart';
import 'package:file_picker/file_picker.dart';

class PhotoBloc extends BaseBloc {
  final PhotoRepository _photoRepository = PhotoRepository();

  late BehaviorSubject<List<PhotoItem>> _photoItemsSubject;

  Stream<List<PhotoItem>> get photoItemsStream => _photoItemsSubject.stream;

  @override
  void init() {
    super.init();
    _photoItemsSubject = BehaviorSubject.seeded([]);
    getPhotos();
  }

  @override
  void dispose() {
    _photoItemsSubject.close();
    super.dispose();
  }

  Map<String, List<PhotoItem>> convertToMap(List<PhotoItem> list) {
    if (list.isEmpty) return {};
    Map<String, List<PhotoItem>> result = {};
    for (PhotoItem item in list) {
      String dateString = DateTimeUtils.toLocalDate(item.createdAt);
      if (dateString == '') {
        dateString = '?';
      } 
      if (result.containsKey(dateString)) {
        int index = result.keys.toList().indexWhere((element) => element == dateString);
        result.values.elementAt(index).add(item);
      } else {
        result.addAll({dateString: [item]});
      }
    }
    return result;
  }

  Future<void> getPhotos({int pageSize = 30, int pageNumber = 1}) async {
    try {
      final response = await callRequest(
        future: _photoRepository.getPhotos,
        namedArguments: {
          #pageSize: pageSize,
        }
      );
      if (response == null) {
        _photoItemsSubject.add([]);
        return;
      }

      var parsed = response['mediaItems'] as List<dynamic>;
      List<PhotoItem> result = [];
      for (var item in parsed) {
        result.add(PhotoItem.fromMap(item));
      }
      _photoItemsSubject.add(result);
    } catch (e) {
      print(e);
      _photoItemsSubject.add([]);
    }
  }

  Future<void> uploadPhoto() async {
    try {
      print('start uploading photo');
      FilePickerResult? pickFileResult = await FilePicker.platform.pickFiles(type: FileType.image);
      if (pickFileResult == null) {
        print('pickFileResult null');
        return;
      };
      File file = File(pickFileResult.files.single.path!);
      final response = await callRequest(
        future: _photoRepository.uploadPhoto,
        positionalArguments: [file],
      );
      print('done uploading photo');
    } catch (e) {
      print('error uploading photo');
      print(e);
    }
  }

  



  


}