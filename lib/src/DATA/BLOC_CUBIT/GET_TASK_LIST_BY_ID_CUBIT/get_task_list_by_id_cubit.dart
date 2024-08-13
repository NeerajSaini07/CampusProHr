import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_TASK_DATA_CUBIT/get_task_data_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskListByIdModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getTaskDataRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getTaskListByIdRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_task_list_by_id_state.dart';

class GetTaskListByIdCubit extends Cubit<GetTaskListByIdState> {
  final GetTaskListByIdRepository _repository;
  GetTaskListByIdCubit(this._repository) : super(GetTaskListByIdInitial());

  Future<void> getTaskDataCubitData(Map<String, String?> payload) async {
    if (await isInternetPresent()) {
      try {
        emit(GetTaskListByIdLoadInProgress());
        var data = await _repository.getData(payload);
        emit(GetTaskListByIdLoadSuccess(data));
      } catch (e) {
        emit(GetTaskListByIdLoadFail('$e'));
      }
    } else {
      emit(GetTaskListByIdLoadFail(NO_INTERNET));
    }
  }
}
