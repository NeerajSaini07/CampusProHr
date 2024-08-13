import 'package:campus_pro/src/DATA/API_SERVICES/dashboardEnquiryApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/dateSheetStudentApi.dart';
import 'package:campus_pro/src/DATA/MODELS/dashboardEnquiryModel.dart';
import 'package:campus_pro/src/DATA/MODELS/dateSheetStudentModel.dart';

abstract class DashboardEnquiryRepositoryAbs {
  Future<DashboardEnquiryModel> dashboardEnquiry(
      Map<String, String?> dashboardEnquiryData);
}

class DashboardEnquiryRepository extends DashboardEnquiryRepositoryAbs {
  final DashboardEnquiryApi _api;
  DashboardEnquiryRepository(this._api);

  @override
  Future<DashboardEnquiryModel> dashboardEnquiry(
      Map<String, String?> dashboardEnquiryData) async {
    final data = await _api.dashboardEnquiry(dashboardEnquiryData);
    return data;
  }
}
