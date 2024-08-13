import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/sendStudentDetailsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'send_student_details_state.dart';

class SendStudentDetailsCubit extends Cubit<SendStudentDetailsState> {
  //Dependency
  final SendStudentDetailsRepository _repository;

  SendStudentDetailsCubit(this._repository)
      : super(SendStudentDetailsInitial());

  Future<void> sendStudentDetailsCubitCall(
      Map<String, String?> studentData) async {
    if (await isInternetPresent()) {
      try {
        emit(SendStudentDetailsLoadInProgress());
        final data = await _repository.sendStudent(studentData);
        emit(SendStudentDetailsLoadSuccess(data));
      } catch (e) {
        emit(SendStudentDetailsLoadFail("$e"));
      }
    } else {
      emit(SendStudentDetailsLoadFail(NO_INTERNET));
    }
  }
}
