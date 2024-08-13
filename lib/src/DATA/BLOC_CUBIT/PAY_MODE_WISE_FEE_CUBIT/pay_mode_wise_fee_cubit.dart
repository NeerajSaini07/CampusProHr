import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/payModeWiseFeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/payModeWiseFeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'pay_mode_wise_fee_state.dart';

class PayModeWiseFeeCubit extends Cubit<PayModeWiseFeeState> {
  final PayModeWiseFeeRepository _repository;
  PayModeWiseFeeCubit(this._repository) : super(PayModeWiseFeeInitial());

  Future<void> payModeWiseFeeCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(PayModeWiseFeeLoadInProgress());
        final data = await _repository.payModeWiseFeeData(requestPayload);
        emit(PayModeWiseFeeLoadSuccess(data));
      } catch (e) {
        emit(PayModeWiseFeeLoadFail("$e"));
      }
    } else {
      emit(PayModeWiseFeeLoadFail(NO_INTERNET));
    }
  }
}