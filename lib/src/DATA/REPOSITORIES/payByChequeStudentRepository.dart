import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/applyForLeaveApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/payByChequeStudentApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';

abstract class PayByChequeStudentRepositoryAbs {
  Future<bool> payByChequeStudent(
      Map<String, String> chequeData, File? _pickedImage);
}

class PayByChequeStudentRepository extends PayByChequeStudentRepositoryAbs {
  final PayByChequeStudentApi _api;
  PayByChequeStudentRepository(this._api);
  @override
  Future<bool> payByChequeStudent(
      Map<String, String> chequeData, File? _pickedImage) async {
    final data = await _api.payByChequeStudent(chequeData, _pickedImage);
    return data;
  }
}
