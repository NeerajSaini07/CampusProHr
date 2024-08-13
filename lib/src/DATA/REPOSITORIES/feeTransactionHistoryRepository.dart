import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/feeTransactionhistoryApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeTransactionHistoryModel.dart';

abstract class FeeTransactionHistoryRepositoryAbs {
  Future<List<FeeTransactionHistoryModel>> feeTransactionHistory(
      Map<String, String> feeData);
}

class FeeTransactionHistoryRepository
    extends FeeTransactionHistoryRepositoryAbs {
  final FeeTransactionHistoryApi _api;
  FeeTransactionHistoryRepository(this._api);
  @override
  Future<List<FeeTransactionHistoryModel>> feeTransactionHistory(
      Map<String, String?> feeData) async {
    final data = await _api.feeTransactionHistory(feeData);
    return data;
  }
}
