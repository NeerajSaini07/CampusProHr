import 'package:campus_pro/src/DATA/API_SERVICES/groupWiseEmployeeMeetingApi.dart';
import 'package:campus_pro/src/DATA/MODELS/groupWiseEmployeeMeetingModel.dart';

abstract class GroupWiseEmployeeMeetingRepositoryAbs {
  Future<List<GroupWiseEmployeeMeetingModel>> getGroups(Map<String, String> groupData);
}

class GroupWiseEmployeeMeetingRepository extends GroupWiseEmployeeMeetingRepositoryAbs {
  final GroupWiseEmployeeMeetingApi _api;
  GroupWiseEmployeeMeetingRepository(this._api);
  @override
  Future<List<GroupWiseEmployeeMeetingModel>> getGroups(Map<String, String?> groupData) async {
    final data = await _api.getGroups(groupData);
    return data;
  }
}