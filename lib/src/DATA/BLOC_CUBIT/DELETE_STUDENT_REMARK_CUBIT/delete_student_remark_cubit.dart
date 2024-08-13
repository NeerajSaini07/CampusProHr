import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/deleteStudentRemarkRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/log_in_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../UTILS/internetCheck.dart';

part 'delete_student_remark_state.dart';

class DeleteStudentRemarkCubit extends Cubit<DeleteStudentRemarkState> {
  //Dependency
  final DeleteStudentRemarkRepository _repository;

  DeleteStudentRemarkCubit(this._repository)
      : super(DeleteStudentRemarkInitial());

  Future<void> deleteStudentRemarkCubitCall(
      Map<String, String> deleteData) async {
    if (await isInternetPresent()) {
      try {
        emit(DeleteStudentRemarkLoadInProgress());
        final data = await _repository.deleteRemark(deleteData);
        emit(DeleteStudentRemarkLoadSuccess(data));
      } catch (e) {
        emit(DeleteStudentRemarkLoadFail("$e"));
      }
    } else {
      emit(DeleteStudentRemarkLoadFail(NO_INTERNET));
    }
  }
}
