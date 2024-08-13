import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/deleteClassroomRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'delete_classroom_state.dart';

class DeleteClassroomCubit extends Cubit<DeleteClassroomState> {
  final DeleteClassroomRepository _repository;

  DeleteClassroomCubit(this._repository) : super(DeleteClassroomInitial());

  Future<void> deleteClassroomCubitCall(Map<String, String?> classData) async {
    if (await isInternetPresent()) {
      try {
        emit(DeleteClassroomLoadInProgress());
        final data = await _repository.classroomData(classData);
        emit(DeleteClassroomLoadSuccess(data));
      } catch (e) {
        emit(DeleteClassroomLoadFail("$e"));
      }
    } else {
      emit(DeleteClassroomLoadFail(NO_INTERNET));
    }
  }
}