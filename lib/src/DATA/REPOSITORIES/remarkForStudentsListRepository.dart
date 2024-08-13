import 'package:campus_pro/src/DATA/API_SERVICES/remarkForStudentsListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/remarkForStudentListModel.dart';

abstract class RemarkForStudentListRepositoryAbs {
  Future<List<RemarkForStudentListModel>> remarkList(
      Map<String, String?> remarkData);
}

class RemarkForStudentListRepository extends RemarkForStudentListRepositoryAbs {
  final RemarkForStudentListApi _api;
  RemarkForStudentListRepository(this._api);

  Future<List<RemarkForStudentListModel>> remarkList(
      Map<String, String?> remarkData) async {
    final data = await _api.remarkList(remarkData);
    return data;
  }
}
