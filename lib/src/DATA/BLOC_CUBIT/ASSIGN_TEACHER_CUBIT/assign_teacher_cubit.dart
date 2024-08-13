import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignTeacherRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'assign_teacher_state.dart';

class AssignTeacherCubit extends Cubit<AssignTeacherState> {
  final AssignTeacherRepository _repository;
  AssignTeacherCubit(this._repository) : super(AssignTeacherInitial());

  Future<void> assignTeacherCubitCall(Map<String, String?> feeData) async {
    if (await isInternetPresent()) {
      try {
        emit(AssignTeacherLoadInProgress());
        final data = await _repository.assignTeacher(feeData);
        emit(AssignTeacherLoadSuccess(data));
      } catch (e) {
        emit(AssignTeacherLoadFail("$e"));
      }
    } else {
      emit(AssignTeacherLoadFail(NO_INTERNET));
    }
  }
}
