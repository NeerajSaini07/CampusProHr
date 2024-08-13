import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/appUserListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/appUserListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'app_user_list_state.dart';

class AppUserListCubit extends Cubit<AppUserListState> {
  final AppUserListRepository _repository;
  AppUserListCubit(this._repository) : super(AppUserListInitial());

  Future<void> appUserListCubitCall(Map<String, String?> requestPayload, bool coordinator) async {
    if (await isInternetPresent()) {
      try {
        emit(AppUserListLoadInProgress());
        final data = await _repository.appUserList(requestPayload, coordinator);
        emit(AppUserListLoadSuccess(data));
      } catch (e) {
        emit(AppUserListLoadFail("$e"));
      }
    } else {
      emit(AppUserListLoadFail(NO_INTERNET));
    }
  }
}
