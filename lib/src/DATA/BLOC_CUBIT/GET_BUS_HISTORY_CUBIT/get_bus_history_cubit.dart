import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getBusHistoryModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getBusHistoryRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_bus_history_state.dart';

class GetBusHistoryCubit extends Cubit<GetBusHistoryState> {
  final GetBusHistoryRepository repository;
  GetBusHistoryCubit(this.repository) : super(GetBusHistoryInitial());

  Future<void> getBusHistoryCubit(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetBusHistoryLoadInProgress());
        var data = await repository.getBusHistory(request);
        emit(GetBusHistoryLoadSuccess(data));
      } catch (e) {
        emit(GetBusHistoryLoadFail('$e'));
      }
    } else {
      emit(GetBusHistoryLoadFail(NO_INTERNET));
    }
  }
}
