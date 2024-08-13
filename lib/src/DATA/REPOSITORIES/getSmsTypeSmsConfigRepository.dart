
import 'package:campus_pro/src/DATA/API_SERVICES/getSmsTypeSmsConfigApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getSmsTypeSmsConfigModel.dart';

abstract class GetSmsTypeSmsConfigRepositoryAbs{

  Future<List<GetSmsTypeSmsConfigModel>> getSmsType(Map<String,String?> request);

}

class GetSmsTypeSmsConfigRepository extends GetSmsTypeSmsConfigRepositoryAbs{
  final GetSmsTypeSmsConfigApi _api;
  GetSmsTypeSmsConfigRepository(this._api);

  Future<List<GetSmsTypeSmsConfigModel>> getSmsType(Map<String,String?> request){
    var data = _api.getSmsType(request);
    return data;
  }
}