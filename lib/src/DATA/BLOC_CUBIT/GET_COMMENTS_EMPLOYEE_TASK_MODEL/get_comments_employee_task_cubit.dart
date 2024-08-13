import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getCommentsEmployeeTaskModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getCommentsEmployeeTaskRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_comments_employee_task_state.dart';

class GetCommentsEmployeeTaskCubit extends Cubit<GetCommentsEmployeeTaskState> {
  final GetCommentsEmployeeTaskRepository _repository;
  GetCommentsEmployeeTaskCubit(this._repository)
      : super(GetCommentsEmployeeTaskInitial());

  Future<void> getCommentsEmployeeTaskData(Map<String, String?> payload) async {
    if (await isInternetPresent()) {
      try {
        emit(GetCommentsEmployeeLoadInProgress());
        var data = await _repository.getData(payload);
        emit(GetCommentsEmployeeLoadSuccess(data));
      } catch (e) {
        emit(GetCommentsEmployeeLoadFail('$e'));
      }
    } else {
      emit(GetCommentsEmployeeLoadFail(NO_INTERNET));
    }
  }
}
