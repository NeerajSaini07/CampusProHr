import 'package:campus_pro/src/DATA/API_SERVICES/notificationsApi.dart';
import 'package:campus_pro/src/DATA/MODELS/notificationsModel.dart';
import 'package:campus_pro/src/databaseHelperClass.dart';

abstract class NotificationsRepositoryAbs {
  Future<List<NotificationsModel>> notificationData(
      Map<String, String?> requestPayload);
}

class NotificationsRepository extends NotificationsRepositoryAbs {
  final NotificationsApi _api;
  NotificationsRepository(this._api);

  Future<List<NotificationsModel>> notificationData(
      Map<String, String?> requestPayload) async {
    // // DataBaseHelper.deleteDatabase();
    // var dataFromDatabase = await DataBaseHelper.getItems();

    // if (dataFromDatabase.length > 0) {
    //   return dataFromDatabase;
    // } else {
    //   final data = await _api.notificationData(requestPayload);
    //   data.forEach((element) {
    //     DataBaseHelper.createItem(
    //         smsId: element.smsId,
    //         smsType: element.smsType,
    //         toNumber: element.toNumber,
    //         alertDate: element.alertMessage,
    //         alertMessage: element.alertMessage);
    //   });
    //   return data;
    // }
    //

    final data = await _api.notificationData(requestPayload);
    return data;
  }
}
