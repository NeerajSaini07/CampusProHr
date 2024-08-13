import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentFeeFineRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'student_fee_fine_state.dart';

class StudentFeeFineCubit extends Cubit<StudentFeeFineState> {
  final StudentFeeFineRepository _repository;
  StudentFeeFineCubit(this._repository) : super(StudentFeeFineInitial());

  Future<void> studentFeeFineCubitCall(Map<String, String?> feeData) async {
    if (await isInternetPresent()) {
      try {
        emit(StudentFeeFineLoadInProgress());
        final data = await _repository.studentFeeFine(feeData);
        emit(StudentFeeFineLoadSuccess(data));
      } catch (e) {
        emit(StudentFeeFineLoadFail("$e"));
      }
    } else {
      emit(StudentFeeFineLoadFail(NO_INTERNET));
    }
  }
}
