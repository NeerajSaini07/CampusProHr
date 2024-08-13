import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/payUBizzHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/PAYMENT_GATEWAY_REPOSITORY/payUBizzHashRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'pay_u_biz_hash_state.dart';

class PayUBizHashCubit extends Cubit<PayUBizHashState> {
  final PayUBizHashRepository _repository;
  PayUBizHashCubit(this._repository) : super(PayUBizHashInitial());

  Future<void> payUBizHashCubitCall(Map<String, String?> sendData) async {
    if (await isInternetPresent()) {
      try {
        emit(PayUBizHashLoadInProgress());
        final data = await _repository.payUBizHash(sendData);
        emit(PayUBizHashLoadSuccess(data));
      } catch (e) {
        emit(PayUBizHashLoadFail("$e"));
      }
    } else {
      emit(PayUBizHashLoadFail(NO_INTERNET));
    }
  }
}
