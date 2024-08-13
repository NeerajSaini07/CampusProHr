import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveSmsTypeSmsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_sms_type_state.dart';

class SaveSmsTypeCubit extends Cubit<SaveSmsTypeState> {
  final SaveSmsTypeSmsRepository _repository;
  SaveSmsTypeCubit(this._repository) : super(SaveSmsTypeInitial());

  Future<void> saveSmsTypeCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveSmsTypeLoadInProgress());
        var data = await _repository.saveSms(request);
        emit(SaveSmsTypeLoadSuccess(data));
      } catch (e) {
        emit(SaveSmsTypeLoadFail('$e'));
      }
    } else {
      emit(SaveSmsTypeLoadFail(NO_INTERNET));
    }
  }
}
