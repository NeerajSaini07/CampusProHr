import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getPopupMessageListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getPopupMessageListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_popup_message_list_state.dart';

class GetPopupMessageListCubit extends Cubit<GetPopupMessageListState> {
  final GetPopupMessageListRepository repository;
  GetPopupMessageListCubit(this.repository)
      : super(GetPopupMessageListInitial());

  Future<void> getPopupMessageListCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetPopupMessageListLoadInProgress());
        var data = await repository.getPopupList(request);
        emit(GetPopupMessageListLoadSuccess(data));
      } catch (e) {
        emit(GetPopupMessageListLoadFail('$e'));
      }
    } else {
      emit(GetPopupMessageListLoadFail(NO_INTERNET));
    }
  }
}
