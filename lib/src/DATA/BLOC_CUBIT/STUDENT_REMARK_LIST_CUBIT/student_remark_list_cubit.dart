import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentRemarkListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/log_in_repository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentRemarkListRepository.dart';
import 'package:equatable/equatable.dart';

import '../../../UTILS/internetCheck.dart';
part 'student_remark_list_state.dart';

class StudentRemarkListCubit extends Cubit<StudentRemarkListState> {
  //Dependency
  final StudentRemarkListRepository _repository;

  StudentRemarkListCubit(this._repository) : super(StudentRemarkListInitial());

  Future<void> studentRemarkListCubitCall(
      Map<String, String> remarkData) async {
    if (await isInternetPresent()) {
      try {
        emit(StudentRemarkListLoadInProgress());
        final data = await _repository.studentRemark(remarkData);
        emit(StudentRemarkListLoadSuccess(data));
      } catch (e) {
        emit(StudentRemarkListLoadFail("$e"));
      }
    } else {
      emit(StudentRemarkListLoadFail(NO_INTERNET));
    }
  }
}
