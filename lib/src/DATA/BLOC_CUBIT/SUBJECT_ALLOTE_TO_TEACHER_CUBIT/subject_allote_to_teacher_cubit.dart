import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/subjectAlloteToTeacherRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'subject_allote_to_teacher_state.dart';

class SubjectAlloteToTeacherCubit extends Cubit<SubjectAlloteToTeacherState> {
  final SubjectAlloteToTeacherRepository repository;
  SubjectAlloteToTeacherCubit(this.repository) : super(SubjectAlloteToTeacherInitial());

  Future<void> subjectAlloteToTeacherCubitCall(Map<String,String?> request) async{
    if(await isInternetPresent()){
      try{
        emit(SubjectAlloteToTeacherLoadInProgress());
        final data =await repository.alloteSubject(request);
        emit(SubjectAlloteToTeacherLoadSucces(data));
      }
      catch(e){
        emit(SubjectAlloteToTeacherLoadFail('$e'));
      }
    }
    else{
      emit(SubjectAlloteToTeacherLoadFail(NO_INTERNET));
    }
  }

}
