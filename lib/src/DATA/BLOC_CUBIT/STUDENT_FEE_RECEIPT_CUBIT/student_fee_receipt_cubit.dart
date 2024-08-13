import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentFeeReceiptModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentFeeReceiptRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'student_fee_receipt_state.dart';

class StudentFeeReceiptCubit extends Cubit<StudentFeeReceiptState> {
  final StudentFeeReceiptRepository _repository;
  StudentFeeReceiptCubit(this._repository) : super(StudentFeeReceiptInitial());

  Future<void> studentFeeReceiptCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(StudentFeeReceiptLoadInProgress());
        final data = await _repository.finalReceiptData(requestPayload);
        emit(StudentFeeReceiptLoadSuccess(data));
      } catch (e) {
        emit(StudentFeeReceiptLoadFail("$e"));
      }
    } else {
      emit(StudentFeeReceiptLoadFail(NO_INTERNET));
    }
  }
}
