import 'package:campus_pro/src/DATA/API_SERVICES/examSelectedListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/examSelectedListModel.dart';

abstract class ExamSelectedListRepositoryAbs {
  Future<List<ExamSelectedListModel>> examSelectedList(
      Map<String, String> examData);
}

class ExamSelectedListRepository extends ExamSelectedListRepositoryAbs {
  final ExamSelectedListApi _api;
  ExamSelectedListRepository(this._api);
  @override
  Future<List<ExamSelectedListModel>> examSelectedList(
      Map<String, String?> examData) async {
    final data = await _api.examSelectedList(examData);
    return data;
  }
}
