import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/applyForLeaveApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';

abstract class ApplyForLeaveRepositoryAbs {
  Future<String> applyForLeave(Map<String, String> userData);
}

class ApplyForLeaveRepository extends ApplyForLeaveRepositoryAbs {
  final ApplyForLeaveApi _api;
  ApplyForLeaveRepository(this._api);
  @override
  Future<String> applyForLeave(Map<String, String?> userData) async {
    final data = await _api.applyForLeave(userData);
    return data;
  }
}
