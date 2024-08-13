import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/payByChequeStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'pay_by_cheque_student_state.dart';

class PayByChequeStudentCubit extends Cubit<PayByChequeStudentState> {
  final PayByChequeStudentRepository _repository;
  PayByChequeStudentCubit(this._repository)
      : super(PayByChequeStudentInitial());

  Future<void> payByChequeStudentCubitCall(
      Map<String, String> chequeData, File? _pickedImage) async {
    if (await isInternetPresent()) {
      try {
        emit(PayByChequeStudentLoadInProgress());
        final data =
            await _repository.payByChequeStudent(chequeData, _pickedImage);
        emit(PayByChequeStudentLoadSuccess(data));
      } catch (e) {
        emit(PayByChequeStudentLoadFail("$e"));
      }
    } else {
      emit(PayByChequeStudentLoadFail(NO_INTERNET));
    }
  }
}
