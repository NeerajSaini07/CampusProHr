import 'package:campus_pro/src/DATA/API_SERVICES/getTaskDataApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskDataModel.dart';

abstract class GetTaskDataRepositoryAbs {
  Future<List<GetTaskDataModel>> getData(Map<String, String?> payload);
}

class GetTaskDataRepository extends GetTaskDataRepositoryAbs {
  final GetTaskDataApi _api;
  GetTaskDataRepository(this._api);

  Future<List<GetTaskDataModel>> getData(Map<String, String?> payload) {
    var data = _api.getData(payload);
    return data;
  }
}
