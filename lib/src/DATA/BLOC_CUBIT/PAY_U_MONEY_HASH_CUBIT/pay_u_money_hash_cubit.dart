import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/payUMoneyHashModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/PAYMENT_GATEWAY_REPOSITORY/payUMoneyHashRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'pay_u_money_hash_state.dart';

class PayUMoneyHashCubit extends Cubit<PayUMoneyHashState> {
  final PayUMoneyHashRepository _repository;
  PayUMoneyHashCubit(this._repository) : super(PayUMoneyHashInitial());

  Future<void> payUMoneyHashCubitCall(Map<String, String?> sendData) async {
    if (await isInternetPresent()) {
      try {
        emit(PayUMoneyHashLoadInProgress());
        final data = await _repository.payUMoneyHash(sendData);
        emit(PayUMoneyHashLoadSuccess(data));
      } catch (e) {
        emit(PayUMoneyHashLoadFail("$e"));
      }
    } else {
      emit(PayUMoneyHashLoadFail(NO_INTERNET));
    }
  }
}
