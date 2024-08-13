import 'package:campus_pro/src/DATA/API_SERVICES/saveSubjectEnrichmentDetailsApi.dart';

abstract class SaveSubjectEnrichmentDetailsRepositoryAbs {
  Future<String> saveSubjectDetail(Map<String, String?> request);
}

class SaveSubjectEnrichmentDetailsRepository
    extends SaveSubjectEnrichmentDetailsRepositoryAbs {
  final SaveSubjectEnrichmentDetailsApi _api;
  SaveSubjectEnrichmentDetailsRepository(this._api);

  Future<String> saveSubjectDetail(Map<String, String?> request) {
    var data = _api.saveSubjectDetail(request);
    return data;
  }
}
