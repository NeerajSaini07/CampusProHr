import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/profileEditRequestApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/updateEnquiryStatusApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';

abstract class UpdateEnquiryStatusRepositoryAbs {
  Future<bool> updateEnquiryStatus(Map<String, String> updateData);
}

class UpdateEnquiryStatusRepository extends UpdateEnquiryStatusRepositoryAbs {
  final UpdateEnquiryStatusApi _api;
  UpdateEnquiryStatusRepository(this._api);
  @override
  Future<bool> updateEnquiryStatus(Map<String, String?> updateData) async {
    final data = await _api.updateEnquiryStatus(updateData);
    return data;
  }
}
