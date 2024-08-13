import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/saveTaskDetialsApi.dart';

abstract class SaveTaskDetailsRepositoryAbs {
  Future<String> saveTask(Map<String, String> payload, List<File>? img);
}

class SaveTaskDetailsRepository extends SaveTaskDetailsRepositoryAbs {
  final SaveTaskDetailsApi _api;

  SaveTaskDetailsRepository(this._api);

  Future<String> saveTask(Map<String, String> payload, List<File>? img) {
    var data = _api.saveTask(payload, img);
    return data;
  }
}
