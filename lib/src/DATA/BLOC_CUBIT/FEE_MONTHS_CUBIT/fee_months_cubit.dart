import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeMonthsModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feeMonthsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fee_months_state.dart';

class FeeMonthsCubit extends Cubit<FeeMonthsState> {
  final FeeMonthsRepository _repository;
  FeeMonthsCubit(this._repository) : super(FeeMonthsInitial());

  Future<void> feeMonthsCubitCall(Map<String, String?> feeData) async {
    if (await isInternetPresent()) {
      try {
        emit(FeeMonthsLoadInProgress());
        final data = await _repository.feeMonths(feeData);
        emit(FeeMonthsLoadSuccess(data));
      } catch (e) {
        emit(FeeMonthsLoadFail("$e"));
      }
    } else {
      emit(FeeMonthsLoadFail(NO_INTERNET));
    }
  }
}
