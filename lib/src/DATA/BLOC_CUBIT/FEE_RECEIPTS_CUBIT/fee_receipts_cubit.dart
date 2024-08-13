import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeReceiptsModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feeReceiptsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fee_receipts_state.dart';

class FeeReceiptsCubit extends Cubit<FeeReceiptsState> {
  final FeeReceiptsRepository _repository;
  FeeReceiptsCubit(this._repository) : super(FeeReceiptsInitial());

  Future<void> feeReceiptsCubitCall(Map<String, String?> feeData) async {
    if (await isInternetPresent()) {
      try {
        emit(FeeReceiptsLoadInProgress());
        final data = await _repository.feeReceipts(feeData);
        emit(FeeReceiptsLoadSuccess(data));
      } catch (e) {
        emit(FeeReceiptsLoadFail("$e"));
      }
    } else {
      emit(FeeReceiptsLoadFail(NO_INTERNET));
    }
  }
}
