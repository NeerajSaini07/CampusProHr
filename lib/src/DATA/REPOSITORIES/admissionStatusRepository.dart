import 'package:campus_pro/src/DATA/API_SERVICES/admissionStatusApi.dart';
import 'package:campus_pro/src/DATA/MODELS/admissionStatusModel.dart';

abstract class AdmissionStatusRepositoryAbs {
  Future<AdmissionStatusModel> admissionStatus(
      Map<String, String> requestPayload);
}

class AdmissionStatusRepository extends AdmissionStatusRepositoryAbs {
  final AdmissionStatusApi _api;
  AdmissionStatusRepository(this._api);
  @override
  Future<AdmissionStatusModel> admissionStatus(
      Map<String, String?> requestPayload) async {
    final data = await _api.admissionStatus(requestPayload);
    return data;
  }
}
