import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveTaskDetailsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_task_details_state.dart';

class SaveTaskDetailsCubit extends Cubit<SaveTaskDetailsState> {
  final SaveTaskDetailsRepository _repository;
  SaveTaskDetailsCubit(this._repository) : super(SaveTaskDetailsInitial());

  Future<void> saveTaskDetailsCubitCall(
      Map<String, String> payload, List<File>? img) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveTaskDetailsLoadInProgress());
        var data = await _repository.saveTask(payload, img);
        emit(SaveTaskDetailsLoadSuccess(data));
      } catch (e) {
        emit(SaveTaskDetailsLoadFail('$e'));
      }
    } else {
      emit(SaveTaskDetailsLoadFail(NO_INTERNET));
    }
  }
}
