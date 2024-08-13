import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/loadBusRoutesModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/loadBusRoutesRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'load_bus_routes_state.dart';

class LoadBusRoutesCubit extends Cubit<LoadBusRoutesState> {
  final LoadBusRoutesRepository repository;
  LoadBusRoutesCubit(this.repository) : super(LoadBusRoutesInitial());

  Future<void> loadBusRoutesCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(LoadBusRoutesLoadInProgress());
        final data = await repository.getBusRoutes(request);
        emit(LoadBusRoutesLoadSuccess(data));
      } catch (e) {
        emit(LoadBusRoutesLoadFail('$e'));
      }
    } else {
      emit(LoadBusRoutesLoadFail(NO_INTERNET));
    }
  }
}
