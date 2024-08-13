import 'package:campus_pro/src/DATA/API_SERVICES/createUserStudentStatusApi.dart';

abstract class CreateUserStudentStatusAbs{
  Future<bool> createUserStudentStatus(Map<String,String?> createUserData); 
}

class CreateUserStudentStatusRepository extends CreateUserStudentStatusAbs{
  final CreateUserStudentStatusApi _api;
  CreateUserStudentStatusRepository(this._api);
  @override
  Future<bool> createUserStudentStatus(Map<String, String?> createUserData)async {
    final data=await _api.createUserStudentStatus(createUserData);
    return data;
  }

}