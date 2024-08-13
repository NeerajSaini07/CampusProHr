import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/saveEmployeeImageApi.dart';

abstract class SaveEmployeeImageRepositoryAbs {
  Future<bool> saveEmployeeImage(
      Map<String, String> editData, File? _pickedImage);
}

class SaveEmployeeImageRepository extends SaveEmployeeImageRepositoryAbs {
  final SaveEmployeeImageApi _api;
  SaveEmployeeImageRepository(this._api);
  @override
  Future<bool> saveEmployeeImage(
      Map<String, String> editData, File? _pickedImage) async {
    final data = await _api.saveEmployeeImage(editData, _pickedImage);
    return data;
  }
}
