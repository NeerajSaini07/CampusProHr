import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/cceGeneralTeacherRemarksListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/cceGeneralTeacherRemarksListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'cce_general_teacher_remarks_list_state.dart';

class CceGeneralTeacherRemarksListCubit extends Cubit<CceGeneralTeacherRemarksListState> {
  //Dependency
  final CceGeneralTeacherRemarksListRepository _repository;

  CceGeneralTeacherRemarksListCubit(this._repository)
      : super(CceGeneralTeacherRemarksListInitial());

  Future<void> cceGeneralTeacherRemarksListCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(CceGeneralTeacherRemarksListLoadInProgress());
        final data = await _repository.remarkData(request);
        emit(CceGeneralTeacherRemarksListLoadSuccess(data));
      } catch (e) {
        emit(CceGeneralTeacherRemarksListLoadFail("$e"));
      }
    } else {
      emit(CceGeneralTeacherRemarksListLoadFail(NO_INTERNET));
    }
  }
}
