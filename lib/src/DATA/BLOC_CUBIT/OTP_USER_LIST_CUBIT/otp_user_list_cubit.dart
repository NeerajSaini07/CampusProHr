import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/otpUserListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/otpUserListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'otp_user_list_state.dart';

class OtpUserListCubit extends Cubit<OtpUserListState> {
  final OtpUserListRepository _repository;
  OtpUserListCubit(this._repository) : super(OtpUserListInitial());

  Future<void> otpUserListCubitCall(Map<String, String?> requestPayload, bool status) async {
    if (await isInternetPresent()) {
      try {
        emit(OtpUserListLoadInProgress());
        final data = await _repository.otpUserList(requestPayload, status);
        emit(OtpUserListLoadSuccess(data));
      } catch (e) {
        emit(OtpUserListLoadFail("$e"));
      }
    } else {
      emit(OtpUserListLoadFail(NO_INTERNET));
    }
  }
}
