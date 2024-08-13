import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/balanceFeeAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/balanceFeeAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'balance_fee_admin_state.dart';

class BalanceFeeAdminCubit extends Cubit<BalanceFeeAdminState> {
  final BalanceFeeAdminRepository _repository;
  BalanceFeeAdminCubit(this._repository) : super(BalanceFeeAdminInitial());

  Future<void> balanceFeeAdminCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(BalanceFeeAdminLoadInProgress());
        final data = await _repository.balanceFeeAdminData(requestPayload);
        emit(BalanceFeeAdminLoadSuccess(data));
      } catch (e) {
        emit(BalanceFeeAdminLoadFail("$e"));
      }
    } else {
      emit(BalanceFeeAdminLoadFail(NO_INTERNET));
    }
  }
}
