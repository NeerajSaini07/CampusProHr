import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/VerifyIdProofGatePassRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'verify_id_proof_gate_pass_state.dart';

class VerifyIdProofGatePassCubit extends Cubit<VerifyIdProofGatePassState> {
  final VerifyIdProofGatePassRepository _repository;
  VerifyIdProofGatePassCubit(this._repository)
      : super(VerifyIdProofGatePassInitial());

  Future<void> verifyIdProofGatePassCubitCall(
      Map<String, String> payload, File? img) async {
    if (await isInternetPresent()) {
      try {
        emit(VerifyIdProofGatePassLoadInProgress());
        var data = await _repository.verifyId(payload, img);
        emit(VerifyIdProofGatePassLoadSuccess(data));
      } catch (e) {
        emit(VerifyIdProofGatePassLoadFail('$e'));
      }
    } else {
      emit(VerifyIdProofGatePassLoadFail(NO_INTERNET));
    }
  }
}
