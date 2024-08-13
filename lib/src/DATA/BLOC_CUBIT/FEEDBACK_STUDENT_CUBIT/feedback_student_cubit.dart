import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feedbackStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'feedback_student_state.dart';

class FeedbackStudentCubit extends Cubit<FeedbackStudentState> {
  final FeedbackStudentRepository _repository;
  FeedbackStudentCubit(this._repository) : super(FeedbackStudentInitial());

  Future<void> feedbackStudentCubitCall(
      Map<String, String?> sendFeedBack) async {
    if (await isInternetPresent()) {
      try {
        emit(FeedbackStudentLoadInProgress());
        final data = await _repository.sendFeedBack(sendFeedBack);
        emit(FeedbackStudentLoadSuccess(data));
      } catch (e) {
        emit(FeedbackStudentLoadFail("$e"));
      }
    } else {
      emit(FeedbackStudentLoadFail(NO_INTERNET));
    }
  }
}
