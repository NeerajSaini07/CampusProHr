import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingRecipientListAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/meetingRecipientListAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'meeting_recipient_list_admin_state.dart';

class MeetingRecipientListAdminCubit extends Cubit<MeetingRecipientListAdminState> {
  final MeetingRecipientListAdminRepository _repository;
  MeetingRecipientListAdminCubit(this._repository) : super(MeetingRecipientListAdminInitial());

  Future<void> meetingRecipientListAdminCubitCall(Map<String, String?> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(MeetingRecipientListAdminLoadInProgress());
        final data = await _repository.meetingStatus(meetingData);
        emit(MeetingRecipientListAdminLoadSuccess(data));
      } catch (e) {
        emit(MeetingRecipientListAdminLoadFail("$e"));
      }
    } else {
      emit(MeetingRecipientListAdminLoadFail(NO_INTERNET));
    }
  }
}
