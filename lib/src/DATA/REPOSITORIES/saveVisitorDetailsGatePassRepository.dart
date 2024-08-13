import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/saveVisitorDetailsGatePassApi.dart';
import 'package:image_picker/image_picker.dart';

abstract class SaveVisitorDetailsGatePassRepositoryAbs {
  Future<String> saveDetails(Map<String, String> payload, File img);
}

class SaveVisitorDetailsGatePassRepository
    extends SaveVisitorDetailsGatePassRepositoryAbs {
  final SaveVisitorDetailsGatePassApi _api;

  SaveVisitorDetailsGatePassRepository(this._api);

  Future<String> saveDetails(Map<String, String> payload, File img) {
    var data = _api.saveDetails(payload, img);
    return data;
  }
}
