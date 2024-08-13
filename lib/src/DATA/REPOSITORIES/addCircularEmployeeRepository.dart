import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/addCirularEmployeeApi.dart';

abstract class AddCircularEmployeeRepositoryAbs {
  Future<String> addCircularEmployee(
      Map<String, String> userData, List<File>? _filePickedList);
}

class AddCircularEmployeeRepository extends AddCircularEmployeeRepositoryAbs {
  final AddCircularEmployeeApi _api;
  AddCircularEmployeeRepository(this._api);
  @override
  Future<String> addCircularEmployee(
      Map<String, String> userData, List<File>? _filePickedList) async {
    final data = await _api.addCircularEmployee(userData, _filePickedList);
    return data;
  }
}
