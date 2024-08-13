import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/approveBillRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'approve_bill_state.dart';

class ApproveBillCubit extends Cubit<ApproveBillState> {
  final ApproveBillRepository _repository;
  ApproveBillCubit(this._repository) : super(ApproveBillInitial());

  Future<void> approveBillCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(ApproveBillLoadInProgress());
        final data = await _repository.approveBillData(requestPayload);
        emit(ApproveBillLoadSuccess(data));
      } catch (e) {
        emit(ApproveBillLoadFail("$e"));
      }
    } else {
      emit(ApproveBillLoadFail(NO_INTERNET));
    }
  }
}