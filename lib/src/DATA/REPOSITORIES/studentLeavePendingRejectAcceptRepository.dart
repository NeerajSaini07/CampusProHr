import 'package:campus_pro/src/DATA/API_SERVICES/StudentLeaveEmployeeHistoryRejAcpApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/studentLeaveEmployeeHistoryApi.dart';
import 'package:campus_pro/src/DATA/MODELS/studentLeaveEmployeeHistoryModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentLeavePendingRejectAcceptModel.dart';

abstract class studentLeavePendingRejectAcceptRepositoryAbs {
  Future<List<studentLeavePendingRejectAcceptModel>> studentLeaveRejectAccept(
      Map<String, String> requestPayload);
}

class studentLeavePendingRejectAcceptRepository
    extends studentLeavePendingRejectAcceptRepositoryAbs {
  final StudentLeaveEmployeeHistoryRejAcpApi api;

  studentLeavePendingRejectAcceptRepository(this.api);

  Future<List<studentLeavePendingRejectAcceptModel>> studentLeaveRejectAccept(
      Map<String, String?> requestPayload) async {
    final data = api.rejectAcceptLeaves(requestPayload);
    return data;
  }
}
