import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveClassRoomRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_class_room_state.dart';

class SaveClassRoomCubit extends Cubit<SaveClassRoomState> {
  final SaveClassRoomRepository repository;
  SaveClassRoomCubit(this.repository) : super(SaveClassRoomInitial());

  Future<void> saveClassRoomCubitCall(
      Map<String, String> request, List<File>? selectedFile) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveClassRoomLoadInProgress());
        final data = await repository.classRoomSave(request, selectedFile);
        emit(SaveClassRoomLoadSuccess(data));
      } catch (e) {
        emit(SaveClassRoomLoadFail('$e'));
      }
    } else {
      emit(SaveClassRoomLoadFail(NO_INTERNET));
    }
  }
}
