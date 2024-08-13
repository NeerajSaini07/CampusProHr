import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/remarkForStudentListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/remarkForStudentsListRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/log_in_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../UTILS/internetCheck.dart';

part 'remark_for_students_list_state.dart';

class RemarkForStudentsListCubit extends Cubit<RemarkForStudentsListState> {
  //Dependency
  final RemarkForStudentListRepository _repository;

  RemarkForStudentsListCubit(this._repository)
      : super(RemarkForStudentsListInitial());

  Future<void> remarkForStudentsListCubitCall(
      Map<String, String> remarkData) async {
    if (await isInternetPresent()) {
      try {
        emit(RemarkForStudentsListLoadInProgress());
        final data = await _repository.remarkList(remarkData);
        emit(RemarkForStudentsListLoadSuccess(data));
      } catch (e) {
        emit(RemarkForStudentsListLoadFail("$e"));
      }
    } else {
      emit(RemarkForStudentsListLoadFail(NO_INTERNET));
    }
  }
}
