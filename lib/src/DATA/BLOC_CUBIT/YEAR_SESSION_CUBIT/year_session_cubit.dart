import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/yearSessionModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/yearSessionRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'year_session_state.dart';

class YearSessionCubit extends Cubit<YearSessionState> {
  final YearSessionRepository _repository;
  YearSessionCubit(this._repository) : super(YearSessionInitial());

  Future<void> yearSessionCubitCall(Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(YearSessionLoadInProgress());
        final data = await _repository.yearSessionData(requestPayload);
        emit(YearSessionLoadSuccess(data));
      } catch (e) {
        emit(YearSessionLoadFail("$e"));
      }
    } else {
      emit(YearSessionLoadFail(NO_INTERNET));
    }
  }
}
