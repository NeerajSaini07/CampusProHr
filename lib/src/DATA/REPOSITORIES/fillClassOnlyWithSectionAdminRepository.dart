import 'package:campus_pro/src/DATA/API_SERVICES/fillClassOnlyWithSectionAdminApi.dart';
import 'package:campus_pro/src/DATA/MODELS/fillClassOnlyWithSectionAdminModel.dart';

abstract class FillClassOnlyWithSectionAdminRepositoryAbs {
  Future<List<FillClassOnlyWithSectionAdminModel>> getClass(
      Map<String, String?> dataSend);
}

class FillClassOnlyWithSectionAdminRepository
    extends FillClassOnlyWithSectionAdminRepositoryAbs {
  final FillClassOnlyWithSectionAdminApi _api;
  FillClassOnlyWithSectionAdminRepository(this._api);
  @override
  Future<List<FillClassOnlyWithSectionAdminModel>> getClass(
      Map<String, String?> dataSend) async {
    final data = await _api.classList(dataSend);
    return data;
  }
}
