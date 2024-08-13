import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/header_token_repository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

import '../../../globalBlocProvidersFile.dart';

part 'header_token_state.dart';

class HeaderTokenCubit extends Cubit<HeaderTokenState> {
  final HeaderTokenRepository _repository;

  HeaderTokenCubit(this._repository) : super(HeaderTokenInitial());

  Future<void> getHeaderTokenCubitCall(Map<String, String> body) async {
    if (await isInternetPresent()) {
      try {
        emit(HeaderTokenLoadInProgress());
        final data = await _repository.getHeaderToken(body);
        emit(HeaderTokenLoadSuccess(data));
      } catch (e) {
        emit(HeaderTokenLoadFail("$e"));
      }
    } else {
      emit(HeaderTokenLoadFail(NO_INTERNET));
    }
  }
}