import 'package:campus_pro/src/DATA/API_SERVICES/getBusHistoryApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getBusHistoryModel.dart';

class GetBusHistoryRepository {
  final GetBusHistoryApi api;
  GetBusHistoryRepository(this.api);

  Future<List<GetBusHistoryModel>> getBusHistory(
      Map<String, String?> request) async {
    var data = await api.getBusHistortApi(request);
    return data;
  }
}
