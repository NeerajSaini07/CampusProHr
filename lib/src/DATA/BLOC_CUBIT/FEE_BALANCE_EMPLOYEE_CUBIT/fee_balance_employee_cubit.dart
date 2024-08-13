import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feeBalanceEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fee_balance_employee_state.dart';

class FeeBalanceEmployeeCubit extends Cubit<FeeBalanceEmployeeState> {
  final FeeBalanceEmployeeRepository repository;
  FeeBalanceEmployeeCubit(this.repository) : super(FeeBalanceEmployeeInitial());

  Future<void> feeBalanceEmployeeCubitCall(Map<String, String?> feeData) async {
    if (await isInternetPresent()) {
      try {
        emit(FeeBalanceEmployeeLoadInProgress());
        final data = await repository.feeBalanceData(feeData);
        emit(FeeBalanceEmployeeLoadSuccess(data));
      } catch (e) {
        emit(FeeBalanceEmployeeLoadFail("$e"));
      }
    } else {
      emit(FeeBalanceEmployeeLoadFail(NO_INTERNET));
    }
  }
}
