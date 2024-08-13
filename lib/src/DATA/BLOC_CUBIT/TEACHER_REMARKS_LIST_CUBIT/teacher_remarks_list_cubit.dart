import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/teacherRemarksListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/teacherRemarksListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'teacher_remarks_list_state.dart';

class TeacherRemarksListCubit extends Cubit<TeacherRemarksListState> {
  //Dependency
  final TeacherRemarksListRepository _repository;

  TeacherRemarksListCubit(this._repository)
      : super(TeacherRemarksListInitial());

  Future<void> teacherRemarksListCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(TeacherRemarksListLoadInProgress());
        final data = await _repository.remarkData(request);
        emit(TeacherRemarksListLoadSuccess(data));
      } catch (e) {
        emit(TeacherRemarksListLoadFail("$e"));
      }
    } else {
      emit(TeacherRemarksListLoadFail(NO_INTERNET));
    }
  }
}
