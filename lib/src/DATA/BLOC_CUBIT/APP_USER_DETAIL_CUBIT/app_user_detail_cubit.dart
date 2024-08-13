import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/appUserDetailModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/appUserDetailRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'app_user_detail_state.dart';

class AppUserDetailCubit extends Cubit<AppUserDetailState> {
  final AppUserDetailRepository _repository;
  AppUserDetailCubit(this._repository) : super(AppUserDetailInitial());

  Future<void> appUserDetailCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(AppUserDetailLoadInProgress());
        final data = await _repository.appUserDetail(requestPayload);
        emit(AppUserDetailLoadSuccess(data));
      } catch (e) {
        emit(AppUserDetailLoadFail("$e"));
      }
    } else {
      emit(AppUserDetailLoadFail(NO_INTERNET));
    }
  }
}
