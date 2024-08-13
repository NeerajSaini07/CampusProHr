import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/loadEmployeeGroupsModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/loadEmployeeGroupsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'load_employee_groups_state.dart';

class LoadEmployeeGroupsCubit extends Cubit<LoadEmployeeGroupsState> {
  final LoadEmployeeGroupsRepository _repository;
  LoadEmployeeGroupsCubit(this._repository)
      : super(LoadEmployeeGroupsInitial());

  Future<void> loadEmployeeGroupsCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(LoadEmployeeGroupsLoadInProgress());
        final data = await _repository.getEmployee(request);
        emit(LoadEmployeeGroupsLoadSuccess(data));
      } catch (e) {
        emit(LoadEmployeeGroupsLoadFail('$e'));
      }
    } else {
      emit(LoadEmployeeGroupsLoadFail(NO_INTERNET));
    }
  }
}
