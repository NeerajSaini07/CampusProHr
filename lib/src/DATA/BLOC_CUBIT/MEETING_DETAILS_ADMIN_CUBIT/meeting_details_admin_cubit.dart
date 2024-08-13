import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingDetailsAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/meetingDetailsAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'meeting_details_admin_state.dart';

class MeetingDetailsAdminCubit extends Cubit<MeetingDetailsAdminState> {
  final MeetingDetailsAdminRepository _repository;
  MeetingDetailsAdminCubit(this._repository) : super(MeetingDetailsAdminInitial());

  Future<void> meetingDetailsAdminCubitCall(Map<String, String?> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(MeetingDetailsAdminLoadInProgress());
        final data = await _repository.meetingDetailsAdmin(meetingData);
        emit(MeetingDetailsAdminLoadSuccess(data));
      } catch (e) {
        emit(MeetingDetailsAdminLoadFail("$e"));
      }
    } else {
      emit(MeetingDetailsAdminLoadFail(NO_INTERNET));
    }
  }
}