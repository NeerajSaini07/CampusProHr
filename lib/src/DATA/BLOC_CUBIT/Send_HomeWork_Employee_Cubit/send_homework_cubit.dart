import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/sendHomeWorkEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'send_homework_state.dart';

class SendHomeworkEmployeeCubit extends Cubit<SendHomeworkState> {
  final SendHomeWorkEmployeeRepository _repo;

  SendHomeworkEmployeeCubit(this._repo) : super(SendHomeworkInitial());

  Future<void> sendHomeWorkEmployeeCubitCall(
      Map<String, String> requestPayload, List<File>? img) async {
    if (await isInternetPresent()) {
      try {
        emit(SendHomeworkLoadInProgress());
        final data = await _repo.sendHomeWorkEmployee(requestPayload, img);
        emit(SendHomeworkLoadSuccess(data));
      } catch (e) {
        emit(SendHomeworkLoadFail("$e"));
      }
    } else {
      emit(SendHomeworkLoadFail(NO_INTERNET));
    }
  }
}
