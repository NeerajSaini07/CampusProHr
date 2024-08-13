import 'package:campus_pro/src/DATA/API_SERVICES/addNewEnquiryApi.dart';

abstract class AddNewEnquiryRepositoryAbs {
  Future<bool> addNewEnquiry(Map<String, String> enquiryData);
}

class AddNewEnquiryRepository extends AddNewEnquiryRepositoryAbs {
  final AddNewEnquiryApi _api;
  AddNewEnquiryRepository(this._api);
  @override
  Future<bool> addNewEnquiry(Map<String, String?> enquiryData) async {
    final data = await _api.addNewEnquiry(enquiryData);
    return data;
  }
}
