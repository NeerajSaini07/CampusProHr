import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignClassCoordinatorRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'assign_class_coordinator_state.dart';

class AssignClassCoordinatorCubit extends Cubit<AssignClassCoordinatorState> {
  final AssignClassCoordinatorRepository _repository;
  AssignClassCoordinatorCubit(this._repository)
      : super(AssignClassCoordinatorInitial());

  Future<void> assignClassCoordinatorCubitCall(
      Map<String, String> request, List<File>? img) async {
    if (await isInternetPresent()) {
      try {
        emit(AssignClassCoordinatorLoadInProgress());
        var data = await _repository.saveClassCoordinator(request, img);
        emit(AssignClassCoordinatorLoadSuccess(data));
      } catch (e) {
        emit(AssignClassCoordinatorLoadFail('$e'));
      }
    } else {
      emit(AssignClassCoordinatorLoadFail(NO_INTERNET));
    }
  }
}
