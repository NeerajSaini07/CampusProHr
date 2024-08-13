import 'package:campus_pro/src/DATA/API_SERVICES/getTaskDataApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/getTaskListByIdApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskDataModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskListByIdModel.dart';

abstract class GetTaskListByIdRepositoryAbs {
  Future<List<GetTaskListByIdModel>> getData(Map<String, String?> payload);
}

class GetTaskListByIdRepository extends GetTaskListByIdRepositoryAbs {
  final GetTaskListByIdApi _api;
  GetTaskListByIdRepository(this._api);

  Future<List<GetTaskListByIdModel>> getData(Map<String, String?> payload) {
    var data = _api.getData(payload);
    return data;
  }
}
