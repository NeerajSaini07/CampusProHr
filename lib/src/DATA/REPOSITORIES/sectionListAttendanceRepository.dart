import 'package:campus_pro/src/DATA/API_SERVICES/classListAttendanceApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/sectionListAttendanceApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/sectionListAttendanceModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';

abstract class SectionListAttendanceRepositoryAbs {
  Future<List<SectionListAttendanceModel>> getSection(
      Map<String, String> requestPayload);
}

class SectionListAttendanceRepository
    extends SectionListAttendanceRepositoryAbs {
  final SectionListAttendanceApi _api;
  SectionListAttendanceRepository(this._api);

  Future<List<SectionListAttendanceModel>> getSection(
      Map<String, String?> requestPayload) async {
    final data = await _api.getSection(requestPayload);
    return data;
  }
}
