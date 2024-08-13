import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/currentUserEmailForZoomModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/currentUserEmailForZoomRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'current_user_email_for_zoom_state.dart';

class CurrentUserEmailForZoomCubit extends Cubit<CurrentUserEmailForZoomState> {
  final CurrentUserEmailForZoomRepository _repository;
  CurrentUserEmailForZoomCubit(this._repository) : super(CurrentUserEmailForZoomInitial());

  Future<void> currentUserEmailForZoomCubitCall(Map<String, String> emailData) async {
    if (await isInternetPresent()) {
      try {
        emit(CurrentUserEmailForZoomLoadInProgress());
        final data = await _repository.emailId(emailData);
        emit(CurrentUserEmailForZoomLoadSuccess(data));
      } catch (e) {
        emit(CurrentUserEmailForZoomLoadFail("$e"));
      }
    } else {
      emit(CurrentUserEmailForZoomLoadFail(NO_INTERNET));
    }
  }
}
