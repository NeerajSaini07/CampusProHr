import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/cceSubjectTeacherRemarksListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/cceSubjectTeacherRemarksListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'cce_subject_teacher_remarks_list_state.dart';

class CceSubjectTeacherRemarksListCubit extends Cubit<CceSubjectTeacherRemarksListState> {
  //Dependency
  final CceSubjectTeacherRemarksListRepository _repository;

  CceSubjectTeacherRemarksListCubit(this._repository)
      : super(CceSubjectTeacherRemarksListInitial());

  Future<void> cceSubjectTeacherRemarksListCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(CceSubjectTeacherRemarksListLoadInProgress());
        final data = await _repository.remarkData(request);
        emit(CceSubjectTeacherRemarksListLoadSuccess(data));
      } catch (e) {
        emit(CceSubjectTeacherRemarksListLoadFail("$e"));
      }
    } else {
      emit(CceSubjectTeacherRemarksListLoadFail(NO_INTERNET));
    }
  }
}
