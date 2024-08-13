import 'package:campus_pro/src/DATA/API_SERVICES/downloadAppUserDataApi.dart';
import 'package:campus_pro/src/DATA/MODELS/downloadAppUserDataModel.dart';

abstract class DownloadAppUserDataRepositoryAbs {
  Future<List<DownloadAppUserDataModel>> downloadAppUserData(
      Map<String, String> requestPayload);
}

class DownloadAppUserDataRepository extends DownloadAppUserDataRepositoryAbs {
  final DownloadAppUserDataApi _api;
  DownloadAppUserDataRepository(this._api);

  Future<List<DownloadAppUserDataModel>> downloadAppUserData(
      Map<String, String?> requestPayload) async {
    final data = await _api.downloadAppUserData(requestPayload);
    return data;
  }
}
