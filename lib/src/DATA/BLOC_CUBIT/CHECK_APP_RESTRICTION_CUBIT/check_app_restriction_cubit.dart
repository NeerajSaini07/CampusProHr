import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/checkAppRestrictionRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'check_app_restriction_state.dart';

class CheckAppRestrictionCubit extends Cubit<CheckAppRestrictionState> {
  //Dependency
  final CheckAppRestrictionRepository _repository;

  CheckAppRestrictionCubit(this._repository) : super(CheckAppRestrictionInitial());

  Future<void> checkAppRestrictionCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(CheckAppRestrictionLoadInProgress());
        final data = await _repository.checkAppRestriction(request);
        emit(CheckAppRestrictionLoadSuccess(data));
      } catch (e) {
        emit(CheckAppRestrictionLoadFail("$e"));
      }
    } else {
      emit(CheckAppRestrictionLoadFail(NO_INTERNET));
    }
  }
}