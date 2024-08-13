import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/feeTypeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeTypeModel.dart';

abstract class FeeTypeRepositoryAbs {
  Future<List<FeeTypeModel>> feeType(Map<String, String> feeTypeData);
}

class FeeTypeRepository extends FeeTypeRepositoryAbs {
  final FeeTypeApi _api;
  FeeTypeRepository(this._api);
  @override
  Future<List<FeeTypeModel>> feeType(Map<String, String?> feeTypeData) async {
    final data = await _api.feeType(feeTypeData);
    return data;
  }
}
