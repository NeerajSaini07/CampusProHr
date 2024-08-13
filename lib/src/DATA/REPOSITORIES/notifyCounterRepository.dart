import 'package:campus_pro/src/DATA/API_SERVICES/notifyCounterApi.dart';
import 'package:campus_pro/src/DATA/MODELS/notifyCounterModel.dart';

abstract class NotifyCounterRepositoryAbs {
  Future<List<NotifyCounterModel>> notificationData(
      Map<String, String?> requestPayload);
}

class NotifyCounterRepository extends NotifyCounterRepositoryAbs {
  final NotifyCounterApi _api;
  NotifyCounterRepository(this._api);

  Future<List<NotifyCounterModel>> notificationData(
      Map<String, String?> requestPayload) async {
    final data = await _api.notificationData(requestPayload);
    return data;
  }
}
