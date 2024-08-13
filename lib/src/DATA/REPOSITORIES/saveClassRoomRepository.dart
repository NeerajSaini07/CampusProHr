import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/saveClassroomApi.dart';

abstract class SaveClassRoomRepositoryAbs {
  Future<String> classRoomSave(
      Map<String, String> request, List<File>? selectedFile);
}

class SaveClassRoomRepository extends SaveClassRoomRepositoryAbs {
  final SaveClassroomApi _api;

  SaveClassRoomRepository(this._api);

  Future<String> classRoomSave(
      Map<String, String> request, List<File>? selectedFile) {
    final data = _api.classRoomSave(request, selectedFile);
    return data;
  }
}
