import 'package:campus_pro/src/DATA/API_SERVICES/studentLeaveEmployeeHistoryApi.dart';
import 'package:campus_pro/src/DATA/MODELS/studentLeaveEmployeeHistoryModel.dart';

abstract class StudentLeaveEmployeeHistoryRepositoryAbs {
  Future<List<StudentLeaveEmployeeHistoryModel>> studentLeave(
      Map<String, String> requestPayload);
}

class StudentLeaveEmployeeHistoryRepository
    extends StudentLeaveEmployeeHistoryRepositoryAbs {
  final StudentLeaveEmployeeHistoryApi api;

  StudentLeaveEmployeeHistoryRepository(this.api);

  Future<List<StudentLeaveEmployeeHistoryModel>> studentLeave(
      Map<String, String?> requestPayload) async {
    final data = api.getHistory(requestPayload);
    return data;
  }
}
