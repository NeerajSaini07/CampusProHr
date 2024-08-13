import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/deleteHomeworkRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'delete_homework_state.dart';

class DeleteHomeworkCubit extends Cubit<DeleteHomeworkState> {
  final DeleteHomeworkRepository _repository;

  DeleteHomeworkCubit(this._repository) : super(DeleteHomeworkInitial());

  Future<void> deleteHomeworkCubitCall(Map<String, String?> classData) async {
    if (await isInternetPresent()) {
      try {
        emit(DeleteHomeworkLoadInProgress());
        final data = await _repository.homeworkData(classData);
        emit(DeleteHomeworkLoadSuccess(data));
      } catch (e) {
        emit(DeleteHomeworkLoadFail("$e"));
      }
    } else {
      emit(DeleteHomeworkLoadFail(NO_INTERNET));
    }
  }
}