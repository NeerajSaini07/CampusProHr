import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/teachersListMeetingModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/teachersListMeetingRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'teachers_list_meeting_state.dart';

class TeachersListMeetingCubit extends Cubit<TeachersListMeetingState> {
  //Dependency
  final TeachersListMeetingRepository _repository;

  TeachersListMeetingCubit(this._repository)
      : super(TeachersListMeetingInitial());

  Future<void> teachersListMeetingCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(TeachersListMeetingLoadInProgress());
        final data = await _repository.teacherList(request);
        emit(TeachersListMeetingLoadSuccess(data));
      } catch (e) {
        emit(TeachersListMeetingLoadFail("$e"));
      }
    } else {
      emit(TeachersListMeetingLoadFail(NO_INTERNET));
    }
  }
}
