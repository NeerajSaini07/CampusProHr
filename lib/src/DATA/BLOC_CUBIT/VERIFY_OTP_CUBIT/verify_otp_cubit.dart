import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/log_in_repository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/verifyOtpRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  //Dependency
  final VerifyOtpRepository _repository;

  VerifyOtpCubit(this._repository) : super(VerifyOtpInitial());

  Future<void> verifyOtpCubitCall(Map<String, String> otpData) async {
    if (await isInternetPresent()) {
      try {
        emit(VerifyOtpLoadInProgress());
        final data = await _repository.verifyOtp(otpData);
        emit(VerifyOtpLoadSuccess(data));
      } catch (e) {
        emit(VerifyOtpLoadFail("$e"));
      }
    } else {
      emit(VerifyOtpLoadFail(NO_INTERNET));
    }
  }
}
