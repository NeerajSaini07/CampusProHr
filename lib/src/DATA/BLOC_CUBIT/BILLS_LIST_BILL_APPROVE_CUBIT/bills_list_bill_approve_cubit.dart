import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/billsListBillApproveModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/billsListBillApproveRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'bills_list_bill_approve_state.dart';

class BillsListBillApproveCubit extends Cubit<BillsListBillApproveState> {
  final BillsListBillApproveRepository _repository;
  BillsListBillApproveCubit(this._repository) : super(BillsListBillApproveInitial());

  Future<void> billsListBillApproveCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(BillsListBillApproveLoadInProgress());
        final data = await _repository.billsListBillApproveData(requestPayload);
        emit(BillsListBillApproveLoadSuccess(data));
      } catch (e) {
        emit(BillsListBillApproveLoadFail("$e"));
      }
    } else {
      emit(BillsListBillApproveLoadFail(NO_INTERNET));
    }
  }
}
