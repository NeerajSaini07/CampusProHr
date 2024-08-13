import 'package:campus_pro/src/DATA/API_SERVICES/getClasswiseSubjectAdminApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/markAttendanceListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getClasswiseSubjectAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/markAttendanceListEmployeeModel.dart';

abstract class GetClasswiseSubjectAdminRepositoryAbs {
  Future<List<GetClasswiseSubjectAdminModel>> getSubject(
      Map<String, String> requestPayload);
}

class GetClasswiseSubjectAdminRepository
    extends GetClasswiseSubjectAdminRepositoryAbs {
  final GetClasswiseSubjectAdminApi _api;
  GetClasswiseSubjectAdminRepository(this._api);

  Future<List<GetClasswiseSubjectAdminModel>> getSubject(
      Map<String, String?> requestPayload) async {
    final data = await _api.subjectList(requestPayload);
    return data;
  }
}
