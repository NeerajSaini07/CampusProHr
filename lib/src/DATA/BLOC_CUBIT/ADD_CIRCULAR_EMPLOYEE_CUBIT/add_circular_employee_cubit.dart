import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/addCircularEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'add_circular_employee_state.dart';

class AddCircularEmployeeCubit extends Cubit<AddCircularEmployeeState> {
  final AddCircularEmployeeRepository _repo;
  AddCircularEmployeeCubit(this._repo) : super(AddCircularEmployeeInitial());

  Future<void> addCircularEmployeeCubitCall(
      Map<String, String> requestPayload, List<File>? _filePickedList) async {
    if (await isInternetPresent()) {
      try {
        emit(AddCircularEmployeeLoadInProgress());
        final data =
            await _repo.addCircularEmployee(requestPayload, _filePickedList);
        emit(AddCircularEmployeeLoadSuccess(data));
      } catch (e) {
        emit(AddCircularEmployeeLoadFail("$e"));
      }
    } else {
      emit(AddCircularEmployeeLoadFail(NO_INTERNET));
    }
  }
}
