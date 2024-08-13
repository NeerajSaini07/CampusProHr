import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/checkEmailRegistrationModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/checkEmailRegistrationRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/log_in_repository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'check_email_registration_state.dart';

class CheckEmailRegistrationCubit extends Cubit<CheckEmailRegistrationState> {
  //Dependency
  final CheckEmailRegistrationRepository _repository;

  CheckEmailRegistrationCubit(this._repository)
      : super(CheckEmailRegistrationInitial());

  Future<void> checkEmailRegistrationCubitCall(
      Map<String, String> emailData) async {
    if (await isInternetPresent()) {
      try {
        emit(CheckEmailRegistrationLoadInProgress());
        final data = await _repository.checkEmailRegistration(emailData);
        emit(CheckEmailRegistrationLoadSuccess(data));
      } catch (e) {
        emit(CheckEmailRegistrationLoadFail("$e"));
      }
    } else {
      emit(CheckEmailRegistrationLoadFail(NO_INTERNET));
    }
  }
}
