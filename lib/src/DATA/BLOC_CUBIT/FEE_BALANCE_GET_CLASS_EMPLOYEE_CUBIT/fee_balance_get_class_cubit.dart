import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceClassListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feeBalanceClassListEmployeeReposiory.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fee_balance_get_class_state.dart';

class FeeBalanceClassListEmployeeCubit
    extends Cubit<FeeBalanceClassListEmployeeState> {
  final FeeBalanceClassListEmployeeRepositoryAbs _repository;
  FeeBalanceClassListEmployeeCubit(this._repository)
      : super(FeeBalanceGetClassInitial());

  Future<void> feeBalanceClassListEmployeeCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(ClassListEmployeeLoadInProgress());
        final data = await _repository.getClass(userTypeData);
        emit(ClassListEmployeeLoadSuccess(data));
      } catch (e) {
        emit(ClassListEmployeeLoadFail('$e'));
      }
    } else {
      emit(ClassListEmployeeLoadFail(NO_INTERNET));
    }
  }
}
