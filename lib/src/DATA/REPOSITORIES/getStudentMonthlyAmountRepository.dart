import 'package:campus_pro/src/DATA/API_SERVICES/getStudentMonthlyAmountApi.dart';

abstract class GetStudentMonthlyAmountRepositoryAbs {
  Future<String> getAmount(Map<String, String?> request);
}

class GetStudentMonthlyAmountRepository
    extends GetStudentMonthlyAmountRepositoryAbs {
  final GetStudentMonthlyAmountApi _api;
  GetStudentMonthlyAmountRepository(this._api);

  Future<String> getAmount(Map<String, String?> request) {
    var data = _api.getAmount(request);
    return data;
  }
}
