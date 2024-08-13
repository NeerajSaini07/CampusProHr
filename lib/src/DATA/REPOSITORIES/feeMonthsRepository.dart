import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/feeMonthsApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeMonthsModel.dart';

abstract class FeeMonthsRepositoryAbs {
  Future<List<FeeMonthsModel>> feeMonths(Map<String, String> feeMonthsData);
}

class FeeMonthsRepository extends FeeMonthsRepositoryAbs {
  final FeeMonthsApi _api;
  FeeMonthsRepository(this._api);
  @override
  Future<List<FeeMonthsModel>> feeMonths(
      Map<String, String?> feeMonthsData) async {
    final data = await _api.feeMonths(feeMonthsData);
    return data;
  }
}
