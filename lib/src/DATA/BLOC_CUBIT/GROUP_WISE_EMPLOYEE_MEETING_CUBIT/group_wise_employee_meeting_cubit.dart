import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/groupWiseEmployeeMeetingModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/groupWiseEmployeeMeetingRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'group_wise_employee_meeting_state.dart';

class GroupWiseEmployeeMeetingCubit extends Cubit<GroupWiseEmployeeMeetingState> {
  //Dependency
  final GroupWiseEmployeeMeetingRepository _repository;

  GroupWiseEmployeeMeetingCubit(this._repository) : super(GroupWiseEmployeeMeetingInitial());

  Future<void> groupWiseEmployeeMeetingCubitCall(Map<String, String> groupData) async {
    if (await isInternetPresent()) {
      try {
        emit(GroupWiseEmployeeMeetingLoadInProgress());
        final data = await _repository.getGroups(groupData);
        emit(GroupWiseEmployeeMeetingLoadSuccess(data));
      } catch (e) {
        emit(GroupWiseEmployeeMeetingLoadFail("$e"));
      }
    } else {
      emit(GroupWiseEmployeeMeetingLoadFail(NO_INTERNET));
    }
  }
}