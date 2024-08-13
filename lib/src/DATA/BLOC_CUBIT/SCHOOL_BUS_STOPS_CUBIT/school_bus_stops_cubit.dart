import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusStopsModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/schoolBusStopsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'school_bus_stops_state.dart';

class SchoolBusStopsCubit extends Cubit<SchoolBusStopsState> {
  final SchoolBusStopsRepository _repository;
  SchoolBusStopsCubit(this._repository) : super(SchoolBusStopsInitial());

  Future<void> schoolBusStopsCubitCall(Map<String, String?> busData) async {
    if (await isInternetPresent()) {
      try {
        emit(SchoolBusStopsLoadInProgress());
        final data = await _repository.busInfoData(busData);
        emit(SchoolBusStopsLoadSuccess(data));
      } catch (e) {
        emit(SchoolBusStopsLoadFail("$e"));
      }
    } else {
      emit(SchoolBusStopsLoadFail(NO_INTERNET));
    }
  }
}
