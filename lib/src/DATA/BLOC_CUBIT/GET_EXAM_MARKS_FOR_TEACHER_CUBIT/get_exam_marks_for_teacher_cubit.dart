import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getExamMarksForTeacherModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getExamMarksForTeacherRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'get_exam_marks_for_teacher_state.dart';

class GetExamMarksForTeacherCubit extends Cubit<GetExamMarksForTeacherState> {
  final GetExamMarksForTeacherRepository repository;
  GetExamMarksForTeacherCubit(this.repository)
      : super(GetExamMarksForTeacherInitial());

  Future<void> getExamMarksForTeacherCubitCall(
      Map<String, String?> request, int? flag, List<GetExamMarksForTeacherModel> sortData) async {
    if (await isInternetPresent()) {
      try {
        emit(GetExamMarksForTeacherLoadInProgress());
        if (flag == 0) {
          final data = await repository.getExamMarks(request);
          emit(GetExamMarksForTeacherLoadSuccess(data));
        } else {
          emit(GetExamMarksForTeacherLoadSuccess(sortData));
        }
      } catch (e) {
        emit(GetExamMarksForTeacherLoadFail('$e'));
      }
    } else {
      emit(GetExamMarksForTeacherLoadFail(NO_INTERNET));
    }
  }
}
