import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_EMPLOYEE_CUBIT/class_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceMonthListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feeBalanceMonthListEmployeeReposiory.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fee_balance_get_month_state.dart';

class FeeBalanceMonthListCubit extends Cubit<FeeBalanceGetMonthState> {
  final FeeBalanceMonthListEmployeeRepository _repository;
  FeeBalanceMonthListCubit(this._repository)
      : super(FeeBalanceGetMonthInitial());

  Future<void> feeBalanceMonthListCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(MonthListEmployeeLoadInProgress());
        final data = await _repository.getMonth(userTypeData);
        emit(MonthListEmployeeLoadSuccess(data));
      } catch (e) {
        emit(MonthListEmployeeLoadFail('$e'));
      }
    } else {
      emit(MonthListEmployeeLoadFail(NO_INTERNET));
    }
  }
}
