import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/signInWithGoogleApi.dart';
import 'package:campus_pro/src/DATA/MODELS/signInWithGoogleModel.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_with_google_state.dart';

class SignInWithGoogleCubit extends Cubit<SignInWithGoogleState> {
  final SignInWithGoogleApi _api;
  SignInWithGoogleCubit(this._api) : super(SignInWithGoogleInitial());

  Future<void> signInWithGoogleCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(SignInWithGoogleLoadInProgress());
        final data = await _api.signInWithGoogle(request);
        emit(SignInWithGoogleLoadSuccess(data));
      } catch (e) {
        emit(SignInWithGoogleLoadFail('$e'));
      }
    } else {
      emit(SignInWithGoogleLoadFail(NO_INTERNET));
    }
  }
}
