import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/partyTypeBillApproveModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/partyTypeBillApproveRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'party_type_bill_approve_state.dart';

class PartyTypeBillApproveCubit extends Cubit<PartyTypeBillApproveState> {
  final PartyTypeBillApproveRepository _repository;
  PartyTypeBillApproveCubit(this._repository) : super(PartyTypeBillApproveInitial());

  Future<void> partyTypeBillApproveCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(PartyTypeBillApproveLoadInProgress());
        final data = await _repository.partyTypeBillApproveData(requestPayload);
        emit(PartyTypeBillApproveLoadSuccess(data));
      } catch (e) {
        emit(PartyTypeBillApproveLoadFail("$e"));
      }
    } else {
      emit(PartyTypeBillApproveLoadFail(NO_INTERNET));
    }
  }
}
