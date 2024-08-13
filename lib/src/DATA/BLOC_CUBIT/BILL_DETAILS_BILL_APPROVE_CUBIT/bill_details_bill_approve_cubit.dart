import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/billDetailsBillApproveModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/billDetailsBillApproveRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'bill_details_bill_approve_state.dart';

class BillDetailsBillApproveCubit extends Cubit<BillDetailsBillApproveState> {
  final BillDetailsBillApproveRepository _repository;
  BillDetailsBillApproveCubit(this._repository) : super(BillDetailsBillApproveInitial());

  Future<void> billDetailsBillApproveCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(BillDetailsBillApproveLoadInProgress());
        final data = await _repository.billDetailsBillApproveData(requestPayload);
        emit(BillDetailsBillApproveLoadSuccess(data));
      } catch (e) {
        emit(BillDetailsBillApproveLoadFail("$e"));
      }
    } else {
      emit(BillDetailsBillApproveLoadFail(NO_INTERNET));
    }
  }
}