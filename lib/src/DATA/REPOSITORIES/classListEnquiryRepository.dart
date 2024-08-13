import 'package:campus_pro/src/DATA/API_SERVICES/classListApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListEnquiryApi.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEnquiryModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';

abstract class ClassListEnquiryRepositoryAbs {
  Future<List<ClassListEnquiryModel>> classList(
      Map<String, String> requestPayload);
}

class ClassListEnquiryRepository extends ClassListEnquiryRepositoryAbs {
  final ClassListEnquiryApi _api;
  ClassListEnquiryRepository(this._api);

  Future<List<ClassListEnquiryModel>> classList(
      Map<String, String?> requestPayload) async {
    final data = await _api.classList(requestPayload);
    return data;
  }
}
