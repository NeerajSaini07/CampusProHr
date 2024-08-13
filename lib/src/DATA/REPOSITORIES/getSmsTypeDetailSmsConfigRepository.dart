import 'package:campus_pro/src/DATA/API_SERVICES/getSmsTypeDetailSmsConfigApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getSmsTypeDetailSmsConfigModel.dart';

abstract class GetSmsTypeDetailSmsConfigRepositoryAbs {
  Future<List<GetSmsTypeDetailSmsConfigModel>> getSmsTypeDetail(
      Map<String, String?> request);
}

class GetSmsTypeDetailSmsConfigRepository
    extends GetSmsTypeDetailSmsConfigRepositoryAbs {
  final GetSmsTypeDetailSmsConfigApi _api;

  GetSmsTypeDetailSmsConfigRepository(this._api);

  Future<List<GetSmsTypeDetailSmsConfigModel>> getSmsTypeDetail(
      Map<String, String?> request) {
    var data = _api.getSmsTypeDetail(request);
    return data;
  }
}
