import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingStatusListAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/meetingStatusListAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'meeting_status_list_admin_state.dart';

class MeetingStatusListAdminCubit extends Cubit<MeetingStatusListAdminState> {
  final MeetingStatusListAdminRepository _repository;
  MeetingStatusListAdminCubit(this._repository) : super(MeetingStatusListAdminInitial());

  Future<void> meetingStatusListAdminCubitCall(Map<String, String?> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(MeetingStatusListAdminLoadInProgress());
        final data = await _repository.meetingStatus(meetingData);
        emit(MeetingStatusListAdminLoadSuccess(data));
      } catch (e) {
        emit(MeetingStatusListAdminLoadFail("$e"));
      }
    } else {
      emit(MeetingStatusListAdminLoadFail(NO_INTERNET));
    }
  }
}