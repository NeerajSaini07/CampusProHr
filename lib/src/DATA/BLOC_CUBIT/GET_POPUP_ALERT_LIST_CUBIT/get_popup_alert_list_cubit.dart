import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getPopupAlertListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getPopupAlertListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_popup_alert_list_state.dart';

class GetPopupAlertListCubit extends Cubit<GetPopupAlertListState> {
  final GetPopupAlertListRepository repository;
  GetPopupAlertListCubit(this.repository) : super(GetPopupAlertListInitial());

  Future<void> getPopupAlertListCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetPopupAlertListLoadInProgress());
        var data = await repository.getPopupAlertList(request);
        emit(GetPopupAlertListLoadSuccess(data));
      } catch (e) {
        emit(GetPopupAlertListLoadFail('$e'));
      }
    } else {
      emit(GetPopupAlertListLoadFail(NO_INTERNET));
    }
  }
}
