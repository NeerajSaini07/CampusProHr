import 'package:campus_pro/src/DATA/API_SERVICES/approveBillApi.dart';

abstract class ApproveBillRepositoryAbs {
  Future<bool> approveBillData(
      Map<String, String?> requestPayload);
}

class ApproveBillRepository extends ApproveBillRepositoryAbs {
  final ApproveBillApi _api;
  ApproveBillRepository(this._api);

  Future<bool> approveBillData(
      Map<String, String?> requestPayload) async {
    final data = await _api.approveBillData(requestPayload);
    return data;
  }
}
