
 import 'package:campus_pro/src/DATA/API_SERVICES/getTopicAndSkillApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getTopicAndSkillModel.dart';

abstract class GetTopicAndSkillRepositoryAbs {

  Future<List<GetTopicAndSkillModel>> getTopicAndSkill(Map<String,String?> request);

 }

 class GetTopicAndSkillRepository extends GetTopicAndSkillRepositoryAbs{
  final GetTopicAndSkillApi _api;
  GetTopicAndSkillRepository(this._api);

  Future<List<GetTopicAndSkillModel>> getTopicAndSkill(Map<String,String?> request){
    final data = _api.getTopicSkill(request);
    return data;
  }

 }