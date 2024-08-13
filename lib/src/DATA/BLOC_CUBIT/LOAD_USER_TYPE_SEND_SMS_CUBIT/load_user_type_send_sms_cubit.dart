import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/loadUserTypeSendSmsModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/loadUserTypeSendSmsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'load_user_type_send_sms_state.dart';

class LoadUserTypeSendSmsCubit extends Cubit<LoadUserTypeSendSmsState> {
  final LoadUserTypeSendSmsRepository _repository;
  LoadUserTypeSendSmsCubit(this._repository)
      : super(LoadUserTypeSendSmsInitial());

  Future<void> loadUserTypeSendSmsCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(LoadUserTypeSendSmsLoadInProgress());
        var data = await _repository.getUserType(request);
        emit(LoadUserTypeSendSmsLoadSuccess(data));
      } catch (e) {
        emit(LoadUserTypeSendSmsLoadFail('$e'));
      }
    } else {
      emit(LoadUserTypeSendSmsLoadFail(NO_INTERNET));
    }
  }
}
