import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeTransactionHistoryModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feeTransactionHistoryRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fee_transaction_history_state.dart';

class FeeTransactionHistoryCubit extends Cubit<FeeTransactionHistoryState> {
  final FeeTransactionHistoryRepository _repository;
  FeeTransactionHistoryCubit(this._repository)
      : super(FeeTransactionHistoryInitial());

  Future<void> feeTransactionHistoryCubitCall(
      Map<String, String?> historyData) async {
    if (await isInternetPresent()) {
      try {
        emit(FeeTransactionHistoryLoadInProgress());
        final data = await _repository.feeTransactionHistory(historyData);
        emit(FeeTransactionHistoryLoadSuccess(data));
      } catch (e) {
        emit(FeeTransactionHistoryLoadFail("$e"));
      }
    } else {
      emit(FeeTransactionHistoryLoadFail(NO_INTERNET));
    }
  }
}
