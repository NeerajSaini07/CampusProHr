import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskDataModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getTaskDataRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_task_data_state.dart';

class GetTaskDataCubit extends Cubit<GetTaskDataState> {
  final GetTaskDataRepository _repository;
  GetTaskDataCubit(this._repository) : super(GetTaskDataInitial());

  Future<void> getTaskDataCubitData(Map<String, String?> payload) async {
    if (await isInternetPresent()) {
      try {
        emit(GetTaskDataLoadInProgress());
        var data = await _repository.getData(payload);
        emit(GetTaskDataLoadSuccess(data));
      } catch (e) {
        emit(GetTaskDataLoadFail('$e'));
      }
    } else {
      emit(GetTaskDataLoadFail(NO_INTERNET));
    }
  }
}
