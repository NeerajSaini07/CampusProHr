import 'package:campus_pro/src/DATA/MODELS/studentListMeetingModel.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/studentListMeetingApi.dart';

abstract class StudentListMeetingRepositoryAbs {
  Future<List<StudentListMeetingModel>> studentList(
      Map<String, String> studentData);
}

class StudentListMeetingRepository extends StudentListMeetingRepositoryAbs {
  final StudentListMeetingApi _api;
  StudentListMeetingRepository(this._api);
  @override
  Future<List<StudentListMeetingModel>> studentList(
      Map<String, String?> studentData) async {
    final data = await _api.studentListMeeting(studentData);
    return data;
  }
}
