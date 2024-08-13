import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveVisitorDetailsGatePassRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'save_visitor_details_gate_pass_state.dart';

class SaveVisitorDetailsGatePassCubit
    extends Cubit<SaveVisitorDetailsGatePassState> {
  final SaveVisitorDetailsGatePassRepository _repository;

  SaveVisitorDetailsGatePassCubit(this._repository)
      : super(SaveVisitorDetailsGatePassInitial());

  Future<void> saveVisitorDetailsGatePassCubitCall(
      Map<String, String> payload, File _pickedImage) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveVisitorDetailsGatePassLoadInProgress());
        var data = await _repository.saveDetails(payload, _pickedImage);
        emit(SaveVisitorDetailsGatePassLoadSuccess(data));
      } catch (e) {
        emit(SaveVisitorDetailsGatePassLoadFail('$e'));
      }
    } else {
      emit(SaveVisitorDetailsGatePassLoadFail(NO_INTERNET));
    }
  }
}
