import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/log_in_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../UTILS/internetCheck.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  //Dependency
  final LogInRepository _repository;

  LogInCubit(this._repository) : super(LogInInitial());

  Future<void> logInCubitCall(Map<String, String> credentials) async {
    if (await isInternetPresent()) {
      try {
        emit(LogInLoadInProgress());
        final data = await _repository.logIn(credentials);
        emit(LogInLoadSuccess(data));
      } catch (e) {
        print('${e.toString()}');
        emit(LogInLoadFail("$e"));
      }
    } else {
      emit(LogInLoadFail(NO_INTERNET));
    }
  }
}
