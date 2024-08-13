import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/verifyOtpGatePassRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'verify_otp_gate_pass_state.dart';

class VerifyOtpGatePassCubit extends Cubit<VerifyOtpGatePassState> {
  final VerifyOtpGatePassRepository _repository;
  VerifyOtpGatePassCubit(this._repository) : super(VerifyOtpGatePassInitial());

  Future<void> verifyOtpGatePassCubitCall(Map<String, String?> payload) async {
    if (await isInternetPresent()) {
      try {
        emit(VerifyOtpGatePassLoadInProgress());
        var data = await _repository.verifyOtp(payload);
        emit(VerifyOtpGatePassLoadSuccess(data));
      } catch (e) {
        emit(VerifyOtpGatePassLoadFail('$e'));
      }
    } else {
      emit(VerifyOtpGatePassLoadFail(NO_INTERNET));
    }
  }
}
