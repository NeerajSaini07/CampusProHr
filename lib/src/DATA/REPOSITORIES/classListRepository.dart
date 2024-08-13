import 'package:campus_pro/src/DATA/API_SERVICES/classListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';

abstract class ClassListRepositoryAbs {
  Future<List<ClassListModel>> classList(Map<String, String> requestPayload);
}

class ClassListRepository extends ClassListRepositoryAbs {
  final ClassListApi _api;
  ClassListRepository(this._api);

  Future<List<ClassListModel>> classList(
      Map<String, String?> requestPayload) async {
    final data = await _api.classList(requestPayload);
    return data;
  }
}
