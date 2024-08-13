import 'package:campus_pro/src/DATA/API_SERVICES/checkBusAllotApi.dart';

abstract class CheckBusAllotRepositoryAbs {
  Future<String> checkBus(Map<String, String?> request);
}

class CheckBusAllotRepository extends CheckBusAllotRepositoryAbs {
  final CheckBusAllotApi api;
  CheckBusAllotRepository(this.api);

  Future<String> checkBus(Map<String, String?> request) {
    var data = api.checkBus(request);
    return data;
  }
}
