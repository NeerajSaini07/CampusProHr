import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/profileEditRequestApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/viewEnquiryApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/viewEnquiryModel.dart';

abstract class ViewEnquiryRepositoryAbs {
  Future<List<ViewEnquiryModel>> viewEnquiry(Map<String, String> viewData);
}

class ViewEnquiryRepository extends ViewEnquiryRepositoryAbs {
  final ViewEnquiryApi _api;
  ViewEnquiryRepository(this._api);
  @override
  Future<List<ViewEnquiryModel>> viewEnquiry(
      Map<String, String?> viewData) async {
    final data = await _api.viewEnquiry(viewData);
    return data;
  }
}
