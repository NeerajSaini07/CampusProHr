import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/createActivityRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'create_activity_state.dart';

class CreateActivityCubit extends Cubit<CreateActivityState> {
  final CreateActivityRepository _repository;
  CreateActivityCubit(this._repository) : super(CreateActivityInitial());

  Future<void> createActivityCubitCall(
      Map<String, String> sendActivity, List<File>? image) async {
    if (await isInternetPresent()) {
      try {
        emit(CreateActivityLoadInProgress());
        final data = await _repository.createActivityData(sendActivity, image);
        emit(CreateActivityLoadSuccess(data));
      } catch (e) {
        emit(CreateActivityLoadFail("$e"));
      }
    } else {
      emit(CreateActivityLoadFail(NO_INTERNET));
    }
  }
}
