import 'package:campus_pro/src/DATA/API_SERVICES/classListAttendanceApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/sectionListAttendanceAdminApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/sectionListAttendanceApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/classListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/sectionListAttendanceAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/sectionListAttendanceModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';

abstract class SectionListAttendanceAdminRepositoryAbs {
  Future<List<SectionListAttendanceAdminModel>> getSection(
      Map<String, String> requestPayload);
}

class SectionListAttendanceAdminRepository
    extends SectionListAttendanceAdminRepositoryAbs {
  final SectionListAttendanceAdminApi _api;
  SectionListAttendanceAdminRepository(this._api);

  Future<List<SectionListAttendanceAdminModel>> getSection(
      Map<String, String?> requestPayload) async {
    final data = await _api.getSection(requestPayload);
    return data;
  }
}
