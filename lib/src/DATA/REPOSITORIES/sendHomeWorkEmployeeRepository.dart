import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/sendHomeWorkEmployeeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/sendClassRoomCommentApi.dart';

abstract class SendHomeWorkEmployeeRepositoryAbs {
  Future<String> sendHomeWorkEmployee(
      Map<String, String> userData, List<File> img);
}

class SendHomeWorkEmployeeRepository extends SendHomeWorkEmployeeRepositoryAbs {
  final SendHomeWorkEmployeeApi _api;
  SendHomeWorkEmployeeRepository(this._api);
  @override
  Future<String> sendHomeWorkEmployee(
      Map<String, String> userData, List<File>? img) {
    final data = _api.sendHomeWorkEmployee(userData, img);
    return data;
  }
}
