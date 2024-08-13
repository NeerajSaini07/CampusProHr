import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/deleteActivityRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'delete_activity_state.dart';

class DeleteActivityCubit extends Cubit<DeleteActivityState> {
  final DeleteActivityRepository _repository;
  DeleteActivityCubit(this._repository) : super(DeleteActivityInitial());

  Future<void> deleteActivityCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(DeleteActivityLoadInProgress());
        var data = await _repository.deleteActivity(request);
        emit(DeleteActivityLoadSuccess(data));
      } catch (e) {
        emit(DeleteActivityLoadFail('$e'));
      }
    } else {
      emit(DeleteActivityLoadFail(NO_INTERNET));
    }
  }
}
