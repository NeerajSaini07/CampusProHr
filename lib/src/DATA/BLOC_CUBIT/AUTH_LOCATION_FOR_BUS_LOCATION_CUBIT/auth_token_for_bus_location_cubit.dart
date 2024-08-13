import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/authTokenForBusLocationRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'auth_token_for_bus_location_state.dart';

class AuthTokenForBusLocationCubit extends Cubit<AuthTokenForBusLocationState> {
  final AuthTokenForBusLocationRepository _repository;
  AuthTokenForBusLocationCubit(this._repository) : super(AuthTokenForBusLocationInitial());

  Future<void> authTokenForBusLocationCubitCall(
      Map<String, String?> tokenData) async {
    if (await isInternetPresent()) {
      try {
        emit(AuthTokenForBusLocationLoadInProgress());
        final data = await _repository.authToken(tokenData);
        emit(AuthTokenForBusLocationLoadSuccess(data));
      } catch (e) {
        emit(AuthTokenForBusLocationLoadFail("$e"));
      }
    } else {
      emit(AuthTokenForBusLocationLoadFail(NO_INTERNET));
    }
  }
}