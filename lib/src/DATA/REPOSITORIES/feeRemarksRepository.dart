import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/feeRemarksApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeRemarksModel.dart';

abstract class FeeRemarksRepositoryAbs {
  Future<FeeRemarksModel> feeRemarks(Map<String, String> feeRemarksData);
}

class FeeRemarksRepository extends FeeRemarksRepositoryAbs {
  final FeeRemarksApi _api;
  FeeRemarksRepository(this._api);
  @override
  Future<FeeRemarksModel> feeRemarks(
      Map<String, String?> feeRemarksData) async {
    final data = await _api.feeRemarks(feeRemarksData);
    return data;
  }
}
