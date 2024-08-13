import 'package:campus_pro/src/DATA/API_SERVICES/employeeInfoApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/examMarksChartApi.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examMarksChartModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';

abstract class EmployeeInfoRepositoryAbs {
  Future<EmployeeInfoModel> employeeInfo(Map<String, String> employeeData);
}

class EmployeeInfoRepository extends EmployeeInfoRepositoryAbs {
  final EmployeeInfoApi _api;
  EmployeeInfoRepository(this._api);
  @override
  Future<EmployeeInfoModel> employeeInfo(
      Map<String, String?> employeeData) async {
    final data = await _api.employeeInfo(employeeData);
    await UserUtils.cacheEmployeeInfoData(data);
    return data;
  }
}
