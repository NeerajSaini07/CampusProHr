import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusRouteModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/schoolBusRouteRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'school_bus_route_state.dart';

class SchoolBusRouteCubit extends Cubit<SchoolBusRouteState> {
  final SchoolBusRouteRepository _repository;
  SchoolBusRouteCubit(this._repository) : super(SchoolBusRouteInitial());

  Future<void> schoolBusRouteCubitCall(Map<String, String?> routeData) async {
    if (await isInternetPresent()) {
      try {
        emit(SchoolBusRouteLoadInProgress());
        final data = await _repository.fetchBusRoute(routeData);
        emit(SchoolBusRouteLoadSuccess(data));
      } catch (e) {
        emit(SchoolBusRouteLoadFail("$e"));
      }
    } else {
      emit(SchoolBusRouteLoadFail(NO_INTERNET));
    }
  }
}
