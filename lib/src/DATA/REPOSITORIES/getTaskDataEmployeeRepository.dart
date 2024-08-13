import 'package:campus_pro/src/DATA/API_SERVICES/getTaskDataApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/getTaskDataEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskDataEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskDataModel.dart';

abstract class GetTaskDataEmployeeRepositoryAbs {
  Future<List<GetTaskDataEmployeeModel>> getData(Map<String, String?> payload);
}

class GetTaskDataEmployeeRepository extends GetTaskDataEmployeeRepositoryAbs {
  final GetTaskDataEmployeeApi _api;
  GetTaskDataEmployeeRepository(this._api);

  Future<List<GetTaskDataEmployeeModel>> getData(Map<String, String?> payload) {
    var data = _api.getData(payload);
    return data;
  }
}
