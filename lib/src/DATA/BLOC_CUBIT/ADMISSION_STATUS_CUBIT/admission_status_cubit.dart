import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/admissionStatusModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/admissionStatusRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'admission_status_state.dart';

class AdmissionStatusCubit extends Cubit<AdmissionStatusState> {
  //Dependency
  final AdmissionStatusRepository _repository;

  AdmissionStatusCubit(this._repository)
      : super(AdmissionStatusInitial());

  Future<void> admissionStatusCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(AdmissionStatusLoadInProgress());
        final data = await _repository.admissionStatus(request);
        emit(AdmissionStatusLoadSuccess(data));
      } catch (e) {
        emit(AdmissionStatusLoadFail("$e"));
      }
    } else {
      emit(AdmissionStatusLoadFail(NO_INTERNET));
    }
  }
}