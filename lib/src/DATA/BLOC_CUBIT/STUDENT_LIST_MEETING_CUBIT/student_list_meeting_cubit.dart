import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentListMeetingModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentListMeetingRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'student_list_meeting_state.dart';

class StudentListMeetingCubit extends Cubit<StudentListMeetingState> {
  final StudentListMeetingRepository _repository;
  StudentListMeetingCubit(this._repository)
      : super(StudentListMeetingInitial());

  Future<void> studentListMeetingCubitCall(
      Map<String, String?> studentData) async {
    if (await isInternetPresent()) {
      try {
        emit(StudentListMeetingLoadInProgress());
        final data = await _repository.studentList(studentData);
        emit(StudentListMeetingLoadSuccess(data));
      } catch (e) {
        emit(StudentListMeetingLoadFail("$e"));
      }
    } else {
      emit(StudentListMeetingLoadFail(NO_INTERNET));
    }
  }
}
