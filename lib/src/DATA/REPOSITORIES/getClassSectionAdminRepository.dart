import 'package:campus_pro/src/DATA/API_SERVICES/getClassSectionAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getClassSectionAdminModel.dart';

abstract class GetClassSectionAdminRepositoryAbs {
  Future<List<GetClassSectionAdminModel>> getSection(
      Map<String, String?> request);
}

class GetClassSectionAdminRepository extends GetClassSectionAdminRepositoryAbs {
  final GetClassSectionAdminApi _api;
  GetClassSectionAdminRepository(this._api);

  Future<List<GetClassSectionAdminModel>> getSection(
      Map<String, String?> request) {
    final data = _api.getSection(request);
    return data;
  }
}
