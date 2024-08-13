import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/forgotPasswordRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  //Dependency
  final ForgotPasswordRepository _repository;

  ForgotPasswordCubit(this._repository) : super(ForgotPasswordInitial());

  Future<void> forgotPasswordCubitCall(Map<String, String> mobileNo) async {
    if (await isInternetPresent()) {
      try {
        emit(ForgotPasswordLoadInProgress());
        final data = await _repository.forgotPassword(mobileNo);
        emit(ForgotPasswordLoadSuccess(data));
      } catch (e) {
        emit(ForgotPasswordLoadFail("$e"));
      }
    } else {
      emit(ForgotPasswordLoadFail(NO_INTERNET));
    }
  }
}
