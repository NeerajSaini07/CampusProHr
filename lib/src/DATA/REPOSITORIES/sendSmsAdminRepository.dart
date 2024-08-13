
import 'package:campus_pro/src/DATA/API_SERVICES/sendSmsAdminApi.dart';

abstract class SendSmsAdminRepositoryAbs{
  Future<String> submitSms(Map<String,String?> request);
}

class SendSmsAdminRepository extends SendSmsAdminRepositoryAbs{
  final SendSmsAdminApi _api;
  SendSmsAdminRepository(this._api);

  Future<String> submitSms(Map<String,String?> request){
    final data = _api.submitSms(request);
    return data;
  }

}