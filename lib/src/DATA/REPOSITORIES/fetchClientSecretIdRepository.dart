import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/feeTypeApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/fetchClientSecretIdApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeTypeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/fetchClientSecretIdModel.dart';

abstract class FetchClientSecretIdRepositoryAbs {
  Future<FetchClientSecretIdModel> fetchIDs(Map<String, String> feeTypeData);
}

class FetchClientSecretIdRepository extends FetchClientSecretIdRepositoryAbs {
  final FetchClientSecretIdApi _api;
  FetchClientSecretIdRepository(this._api);
  @override
  Future<FetchClientSecretIdModel> fetchIDs(
      Map<String, String?> feeTypeData) async {
    final data = await _api.fetchIDs(feeTypeData);
    return data;
  }
}
