import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingPlatformsModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/meetingPlatformsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'meeting_platforms_state.dart';

class MeetingPlatformsCubit extends Cubit<MeetingPlatformsState> {
  final MeetingPlatformsRepository _repository;
  MeetingPlatformsCubit(this._repository) : super(MeetingPlatformsInitial());

  Future<void> meetingPlatformsCubitCall(
      Map<String, String?> platformData) async {
    if (await isInternetPresent()) {
      try {
        emit(MeetingPlatformsLoadInProgress());
        final data = await _repository.meetingPlatforms(platformData);
        emit(MeetingPlatformsLoadSuccess(data));
      } catch (e) {
        emit(MeetingPlatformsLoadFail("$e"));
      }
    } else {
      emit(MeetingPlatformsLoadFail(NO_INTERNET));
    }
  }
}
