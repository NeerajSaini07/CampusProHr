import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getCoordinatorListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getCoordinatorListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_coordinator_list_state.dart';

class GetCoordinatorListCubit extends Cubit<GetCoordinatorListState> {
  final GetCoordinatorListRepository _repository;
  GetCoordinatorListCubit(this._repository)
      : super(GetCoordinatorListInitial());

  Future<void> getCoordinatorListCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetCoordinatorListLoadInProgress());
        var data = await _repository.getCoordinatorList(request);
        emit(GetCoordinatorListLoadSuccess(data));
      } catch (e) {
        emit(GetCoordinatorListLoadFail('$e'));
      }
    } else {
      emit(GetCoordinatorListLoadFail(NO_INTERNET));
    }
  }
}
