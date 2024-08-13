import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_TASK_DATA_CUBIT/get_task_data_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/assignFollowerListTaskManagementModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskDataModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignFollowerListTaskManagementReporisoty.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getTaskDataRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_assign_list_task_management_state.dart';

class GetAssignListTaskManagementCubit
    extends Cubit<GetAssignListTaskManagementState> {
  final AssignFollowerListTaskManagementReporisoty _repository;
  GetAssignListTaskManagementCubit(this._repository)
      : super(GetAssignListTaskManagementInitial());

  GetTaskDataModel a = GetTaskDataModel();

  Future<void> getAssignListTaskManagementCubitData(
      Map<String, String?> payload) async {
    if (await isInternetPresent()) {
      try {
        emit(GetAssignListTaskManagementLoadInProgress());
        var data = await _repository.getData(payload);
        emit(GetAssignListTaskManagementLoadSuccess(data));
      } catch (e) {
        emit(GetAssignListTaskManagementLoadFail('$e'));
      }
    } else {
      emit(GetAssignListTaskManagementLoadFail(NO_INTERNET));
    }
  }
}
