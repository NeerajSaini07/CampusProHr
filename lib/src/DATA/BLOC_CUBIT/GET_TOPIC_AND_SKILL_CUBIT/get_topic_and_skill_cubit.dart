import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getTopicAndSkillModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getTopicAndSkillRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_topic_and_skill_state.dart';

class GetTopicAndSkillCubit extends Cubit<GetTopicAndSkillState> {
  final GetTopicAndSkillRepository repository;
  GetTopicAndSkillCubit(this.repository) : super(GetTopicAndSkillInitial());

  Future<void> getTopicAndSkillCubitCall(Map<String,String?> request)async{
    if(await isInternetPresent()){
      try{
        emit(GetTopicAndSkillLoadInProgress());
        var data = await repository.getTopicAndSkill(request);
        emit(GetTopicAndSkillLoadSuccess(data));
      }
      catch(e){
        emit(GetTopicAndSkillLoadFail('$e'));
      }
    }
      else{
        emit(GetTopicAndSkillLoadFail(NO_INTERNET));
    }
  }

}
