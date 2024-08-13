import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/downloadAppUserDataModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/downloadAppUserDataRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'download_app_user_data_state.dart';

class DownloadAppUserDataCubit extends Cubit<DownloadAppUserDataState> {
  final DownloadAppUserDataRepository _repository;
  DownloadAppUserDataCubit(this._repository) : super(DownloadAppUserDataInitial());

  Future<void> downloadAppUserDataCubitCall(Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(DownloadAppUserDataLoadInProgress());
        final data = await _repository.downloadAppUserData(requestPayload);
        emit(DownloadAppUserDataLoadSuccess(data));
      } catch (e) {
        emit(DownloadAppUserDataLoadFail("$e"));
      }
    } else {
      emit(DownloadAppUserDataLoadFail(NO_INTERNET));
    }
  }
}
