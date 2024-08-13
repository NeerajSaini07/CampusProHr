import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_TASK_DETAILS_CUBIT/save_task_details_cubit.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveTaskDetailsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
part 'delete_task_detail_state.dart';

class DeleteTaskDetailCubit extends Cubit<DeleteTaskDetailState> {
  final SaveTaskDetailsRepository _repository;
  DeleteTaskDetailCubit(this._repository) : super(DeleteTaskDetailInitial());

  Future<void> deleteTaskDetailsCubitCall(
      Map<String, String> payload, List<File>? img) async {
    if (await isInternetPresent()) {
      try {
        emit(DeleteTaskDetailLoadInProgress());
        var data = await _repository.saveTask(payload, img);
        emit(DeleteTaskDetailLoadSuccess(data));
      } catch (e) {
        emit(DeleteTaskDetailLoadFail('$e'));
      }
    } else {
      emit(DeleteTaskDetailLoadFail(NO_INTERNET));
    }
  }
}
