import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feedbackEnquiryModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feedbackEnquiryRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feedbackStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'feedback_enquiry_state.dart';

class FeedbackEnquiryCubit extends Cubit<FeedbackEnquiryState> {
  final FeedbackEnquiryRepository _repository;
  FeedbackEnquiryCubit(this._repository) : super(FeedbackEnquiryInitial());

  Future<void> feedbackEnquiryCubitCall(
      Map<String, String?> feedbackData) async {
    if (await isInternetPresent()) {
      try {
        emit(FeedbackEnquiryLoadInProgress());
        final data = await _repository.feedbackEnquiry(feedbackData);
        emit(FeedbackEnquiryLoadSuccess(data));
      } catch (e) {
        emit(FeedbackEnquiryLoadFail("$e"));
      }
    } else {
      emit(FeedbackEnquiryLoadFail(NO_INTERNET));
    }
  }
}
