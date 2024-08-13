import 'package:campus_pro/src/DATA/API_SERVICES/getCommentsEmployeeTaskApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/getTaskDataApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getCommentsEmployeeTaskModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskDataModel.dart';

abstract class GetCommentsEmployeeTaskRepositoryAbs {
  Future<List<GetCommentsEmployeeTaskModel>> getData(
      Map<String, String?> payload);
}

class GetCommentsEmployeeTaskRepository
    extends GetCommentsEmployeeTaskRepositoryAbs {
  final GetCommentsEmployeeTaskApi _api;
  GetCommentsEmployeeTaskRepository(this._api);

  Future<List<GetCommentsEmployeeTaskModel>> getData(
      Map<String, String?> payload) {
    var data = _api.getData(payload);
    return data;
  }
}
