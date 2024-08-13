import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectListMeetingModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/subjectListMeetingRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'subject_list_meeting_state.dart';

class SubjectListMeetingCubit extends Cubit<SubjectListMeetingState> {
  final SubjectListMeetingRepository _repository;
  SubjectListMeetingCubit(this._repository)
      : super(SubjectListMeetingInitial());

  Future<void> subjectListMeetingCubitCall(
      Map<String, String?> subjectData) async {
    if (await isInternetPresent()) {
      try {
        emit(SubjectListMeetingLoadInProgress());
        final data = await _repository.subjectList(subjectData);
        emit(SubjectListMeetingLoadSuccess(data));
      } catch (e) {
        emit(SubjectListMeetingLoadFail("$e"));
      }
    } else {
      emit(SubjectListMeetingLoadFail(NO_INTERNET));
    }
  }
}
