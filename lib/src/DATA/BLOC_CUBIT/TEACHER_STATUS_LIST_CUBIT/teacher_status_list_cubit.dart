import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/teacherStatusListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/teacherStatusListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'teacher_status_list_state.dart';

class TeacherStatusListCubit extends Cubit<TeacherStatusListState> {
  //Dependency
  final TeacherStatusListRepository _repository;

  TeacherStatusListCubit(this._repository)
      : super(TeacherStatusListInitial());

  Future<void> teacherStatusListCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(TeacherStatusListLoadInProgress());
        final data = await _repository.teacherList(request);
        emit(TeacherStatusListLoadSuccess(data));
      } catch (e) {
        emit(TeacherStatusListLoadFail("$e"));
      }
    } else {
      emit(TeacherStatusListLoadFail(NO_INTERNET));
    }
  }
}
