import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/leaveRequestApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/leaveRequestModel.dart';

abstract class LeaveRequestRepositoryAbs {
  Future<List<LeaveRequestModel>> leaveRequest(Map<String, String> userData);
}

class LeaveRequestRepository extends LeaveRequestRepositoryAbs {
  final LeaveRequestApi _api;
  LeaveRequestRepository(this._api);
  @override
  Future<List<LeaveRequestModel>> leaveRequest(
      Map<String, String?> userData) async {
    final data = await _api.leaveRequest(userData);
    return data;
  }
}
