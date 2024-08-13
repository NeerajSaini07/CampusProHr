import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/fcmTokenStoreRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fcm_token_store_state.dart';

class FcmTokenStoreCubit extends Cubit<FcmTokenStoreState> {
  final FcmTokenStoreRepository repository;
  FcmTokenStoreCubit(this.repository) : super(FcmTokenStoreInitial());

  Future<void> fcmTokenStoreCubitCall() async {
    if (await isInternetPresent()) {
      try {
        emit(FcmTokenStoreLoadInProgress());
        final data = await repository.saveToken();
        emit(FcmTokenStoreLoadSuccess(data));
      } catch (e) {
        emit(FcmTokenStoreLoadFail("$e"));
      }
    } else {
      emit(FcmTokenStoreLoadFail(NO_INTERNET));
    }
  }
}
