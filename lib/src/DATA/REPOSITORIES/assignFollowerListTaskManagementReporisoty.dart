import 'package:campus_pro/src/DATA/API_SERVICES/assignFollowerListTaskManagementApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/getTaskDataApi.dart';
import 'package:campus_pro/src/DATA/MODELS/assignFollowerListTaskManagementModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskDataModel.dart';

abstract class AssignFollowerListTaskManagementReporisotyAbs {
  Future<List<AssignFollowerListTaskManagementModel>> getData(
      Map<String, String?> payload);
}

class AssignFollowerListTaskManagementReporisoty
    extends AssignFollowerListTaskManagementReporisotyAbs {
  final AssignFollowerListTaskManagementApi _api;
  AssignFollowerListTaskManagementReporisoty(this._api);

  Future<List<AssignFollowerListTaskManagementModel>> getData(
      Map<String, String?> payload) {
    var data = _api.assignList(payload);
    return data;
  }
}
