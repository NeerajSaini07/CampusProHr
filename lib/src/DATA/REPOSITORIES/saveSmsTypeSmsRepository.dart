import 'package:campus_pro/src/DATA/API_SERVICES/saveSmsTypeSmsApi.dart';

abstract class SaveSmsTypeSmsRepositoryAbs {
  Future<String> saveSms(Map<String, String?> request);
}

class SaveSmsTypeSmsRepository extends SaveSmsTypeSmsRepositoryAbs {
  final SaveSmsTypeSmsApi api;

  SaveSmsTypeSmsRepository(this.api);

  Future<String> saveSms(Map<String, String?> request) {
    var data = api.saveSms(request);
    return data;
  }
}
