import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/nearByBusesModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/nearByBusesRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'near_by_buses_state.dart';

class NearByBusesCubit extends Cubit<NearByBusesState> {
  final NearByBusesRepository _repository;
  NearByBusesCubit(this._repository) : super(NearByBusesInitial());

  Future<void> notificationCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(NearByBusesLoadInProgress());
        final data = await _repository.nearByBusesData(requestPayload);
        emit(NearByBusesLoadSuccess(data));
      } catch (e) {
        emit(NearByBusesLoadFail("$e"));
      }
    } else {
      emit(NearByBusesLoadFail(NO_INTERNET));
    }
  }
}