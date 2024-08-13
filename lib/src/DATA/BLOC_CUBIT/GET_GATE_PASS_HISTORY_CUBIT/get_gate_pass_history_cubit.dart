import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getGatePassHistoryModal.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getGatePassHistoryRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_gate_pass_history_state.dart';

class GetGatePassHistoryCubit extends Cubit<GetGatePassHistoryState> {
  final GetGatePassHistoryRepository _repository;
  GetGatePassHistoryCubit(this._repository)
      : super(GetGatePassHistoryInitial());

  Future<void> getGatePassHistoryCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetGatePassHistoryLoadInProgress());
        var data = await _repository.getGatePassHistory(request);
        emit(GetGatePassHistoryLoadSuccess(data));
      } catch (e) {
        emit(GetGatePassHistoryLoadFail('$e'));
      }
    } else {
      emit(GetGatePassHistoryLoadFail(NO_INTERNET));
    }
  }
}
