import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_TASK_DATA_CUBIT/get_task_data_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/assignFollowerListTaskManagementModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskDataModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignFollowerListTaskManagementReporisoty.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getTaskDataRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_follower_list_task_management_state.dart';

class GetFollowerListTaskManagementCubit
    extends Cubit<GetFollowerListTaskManagementState> {
  final AssignFollowerListTaskManagementReporisoty _repository;
  GetFollowerListTaskManagementCubit(this._repository)
      : super(GetFollowerListTaskManagementInitial());

  Future<void> getFollowerListTaskManagementCubitData(
      Map<String, String?> payload) async {
    if (await isInternetPresent()) {
      try {
        emit(GetFollowerListTaskManagementLoadInProgress());
        var data = await _repository.getData(payload);
        emit(GetFollowerListTaskManagementLoadSuccess(data));
      } catch (e) {
        emit(GetFollowerListTaskManagementLoadFail('$e'));
      }
    } else {
      emit(GetFollowerListTaskManagementLoadFail(NO_INTERNET));
    }
  }
}
