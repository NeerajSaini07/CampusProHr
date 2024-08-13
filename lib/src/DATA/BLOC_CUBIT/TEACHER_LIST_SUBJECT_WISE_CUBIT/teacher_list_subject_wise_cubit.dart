import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/teacherListSubjectWiseModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/teacherListSubjectWiseRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'teacher_list_subject_wise_state.dart';

class TeacherListSubjectWiseCubit extends Cubit<TeacherListSubjectWiseState> {
  final TeacherListSubjectWiseRepository repository;
  TeacherListSubjectWiseCubit(this.repository)
      : super(TeacherListSubjectWiseInitial());

  Future<void> teacherListSubjectWiseCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(TeacherListSubjectWiseLoadInProgress());
        final data = await repository.getSubject(request);
        emit(TeacherListSubjectWiseLoadSuccess(data));
      } catch (e) {
        emit(TeacherListSubjectWiseLoadFail('$e'));
      }
    } else {
      emit(TeacherListSubjectWiseLoadFail(NO_INTERNET));
    }
  }
}
