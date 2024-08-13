import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feeHeadBalanceFeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feeHeadBalanceFeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fee_head_balance_fee_state.dart';

class FeeHeadBalanceFeeCubit extends Cubit<FeeHeadBalanceFeeState> {
  final FeeHeadBalanceFeeRepository _repository;
  FeeHeadBalanceFeeCubit(this._repository)
      : super(FeeHeadBalanceFeeInitial());

  Future<void> feeHeadBalanceFeeCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(FeeHeadBalanceFeeLoadInProgress());
        final data = await _repository.feeHeadBalanceFeeData(userTypeData);
        emit(FeeHeadBalanceFeeLoadSuccess(data));
      } catch (e) {
        emit(FeeHeadBalanceFeeLoadFail('$e'));
      }
    } else {
      emit(FeeHeadBalanceFeeLoadFail(NO_INTERNET));
    }
  }
}