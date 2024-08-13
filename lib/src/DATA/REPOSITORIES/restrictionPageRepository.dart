import 'package:campus_pro/src/DATA/API_SERVICES/restrictionPageApi.dart';
import 'package:campus_pro/src/DATA/MODELS/restrictionPageModel.dart';

abstract class RestrictionPageRepositoryAbs {
  Future<List<RestrictionPageModel>> restrictionPage(
      Map<String, String> meetingData);
}

class RestrictionPageRepository extends RestrictionPageRepositoryAbs {
  final RestrictionPageApi _api;
  RestrictionPageRepository(this._api);
  @override
  Future<List<RestrictionPageModel>> restrictionPage(
      Map<String, String?> meetingData) async {
    final data = await _api.restrictionPage(meetingData);
    return data;
  }
}
