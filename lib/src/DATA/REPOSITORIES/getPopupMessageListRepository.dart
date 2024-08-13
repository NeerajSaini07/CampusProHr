import 'package:campus_pro/src/DATA/API_SERVICES/getPopupMessageListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getPopupMessageListModel.dart';

abstract class GetPopupMessageListRepositoryAbs {
  Future<List<GetPopupMessageListModel>> getPopupList(
      Map<String, String?> request);
}

class GetPopupMessageListRepository extends GetPopupMessageListRepositoryAbs {
  final GetPopupMessageListApi _api;

  GetPopupMessageListRepository(this._api);

  Future<List<GetPopupMessageListModel>> getPopupList(
      Map<String, String?> request) {
    var data = _api.getPopupList(request);
    return data;
  }
}
