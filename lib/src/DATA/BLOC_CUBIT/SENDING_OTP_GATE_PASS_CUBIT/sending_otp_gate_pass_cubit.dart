import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/sendingOtpGatePassRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'sending_otp_gate_pass_state.dart';

class SendingOtpGatePassCubit extends Cubit<SendingOtpGatePassState> {
  final SendingOtpGatePassRepository _repository;
  SendingOtpGatePassCubit(this._repository)
      : super(SendingOtpGatePassInitial());

  Future<void> sendingOtpGatePassCubitCall(Map<String, String?> payload) async {
    if (await isInternetPresent()) {
      try {
        emit(SendingOtpGatePassLoadInProgress());
        var data = await _repository.getData(payload);
        emit(SendingOtpGatePassLoadSuccess(data!));
      } catch (e) {
        emit(SendingOtpGatePassLoadFail('$e'));
      }
    } else {
      SendingOtpGatePassLoadFail(NO_INTERNET);
    }
  }
}
