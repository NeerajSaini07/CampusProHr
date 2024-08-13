import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingDetailsModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignTeacherRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/meetingDetailsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'meeting_details_state.dart';

class MeetingDetailsCubit extends Cubit<MeetingDetailsState> {
  final MeetingDetailsRepository _repository;
  MeetingDetailsCubit(this._repository) : super(MeetingDetailsInitial());

  Future<void> meetingDetailsCubitCall(Map<String, String?> meetingData) async {
    if (await isInternetPresent()) {
      try {
        emit(MeetingDetailsLoadInProgress());
        final data = await _repository.meetingDetails(meetingData);
        emit(MeetingDetailsLoadSuccess(data));
      } catch (e) {
        emit(MeetingDetailsLoadFail("$e"));
      }
    } else {
      emit(MeetingDetailsLoadFail(NO_INTERNET));
    }
  }
}
