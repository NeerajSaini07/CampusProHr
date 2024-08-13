import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/studentFeeReceiptApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentFeeReceiptModel.dart';

abstract class StudentFeeReceiptRepositoryAbs {
  Future<List<StudentFeeReceiptModel>> finalReceiptData(
      Map<String, String> finalData);
}

class StudentFeeReceiptRepository extends StudentFeeReceiptRepositoryAbs {
  final StudentFeeReceiptApi _api;
  StudentFeeReceiptRepository(this._api);
  @override
  Future<List<StudentFeeReceiptModel>> finalReceiptData(
      Map<String, String?> finalData) async {
    final data = await _api.finalReceiptData(finalData);
    return data;
  }
}
