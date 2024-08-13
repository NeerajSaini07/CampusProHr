import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/feeReceiptsApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeReceiptsModel.dart';

abstract class FeeReceiptsRepositoryAbs {
  Future<List<FeeReceiptsModel>> feeReceipts(
      Map<String, String> feeReceiptsData);
}

class FeeReceiptsRepository extends FeeReceiptsRepositoryAbs {
  final FeeReceiptsApi _api;
  FeeReceiptsRepository(this._api);
  @override
  Future<List<FeeReceiptsModel>> feeReceipts(
      Map<String, String?> feeReceiptsData) async {
    final data = await _api.feeReceipts(feeReceiptsData);
    return data;
  }
}
