import 'package:campus_pro/src/DATA/API_SERVICES/studentInfoApi.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';

abstract class StudentInfoRepositoryAbs {
  Future<StudentInfoModel> getStudentInfo(Map<String, String> studentData);
}

class StudentInfoRepository extends StudentInfoRepositoryAbs {
  final StudentInfoApi _api;
  StudentInfoRepository(this._api);

  @override
  Future<StudentInfoModel> getStudentInfo(
      Map<String, String> studentData) async {
    final data = await _api.getStudentInfo(studentData);
    await UserUtils.cacheStuInfoData(data);
    return data;
  }
}
