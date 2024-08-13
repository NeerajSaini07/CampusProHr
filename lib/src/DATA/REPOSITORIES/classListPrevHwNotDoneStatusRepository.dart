import 'package:campus_pro/src/DATA/API_SERVICES/classListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListHwStatusAdminApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListPrevHwNotDoneStatusApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/feeBalanceClassListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListHwStatusAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListPrevHwNotDoneStatusModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceClassListEmployeeModel.dart';

abstract class ClassListPrevHwNotDoneStatusRepositoryAbs {
  Future<List<ClassListPrevHwNotDoneStatusModel>> getClass(
      Map<String, String?> requestPayload);
}

class ClassListPrevHwNotDoneStatusRepository
    extends ClassListPrevHwNotDoneStatusRepositoryAbs {
  final ClassListPrevHwNotDoneStatusApi _api;
  ClassListPrevHwNotDoneStatusRepository(this._api);

  Future<List<ClassListPrevHwNotDoneStatusModel>> getClass(
      Map<String, String?> requestPayload) async {
    final data = await _api.getClassList(requestPayload);
    return data;
  }
}
