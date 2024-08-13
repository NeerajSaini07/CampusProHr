import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/airPayHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/PAYMENT_GATEWAY_REPOSITORY/airPayHashModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'air_pay_hash_state.dart';

class AirPayHashCubit extends Cubit<AirPayHashState> {
  final AirPayHashRepository _repository;
  AirPayHashCubit(this._repository) : super(AirPayHashInitial());

  Future<void> airPayHashCubitCall(Map<String, String?> sendData) async {
    if (await isInternetPresent()) {
      try {
        emit(AirPayHashLoadInProgress());
        final data = await _repository.airPayHash(sendData);
        emit(AirPayHashLoadSuccess(data));
      } catch (e) {
        emit(AirPayHashLoadFail("$e"));
      }
    } else {
      emit(AirPayHashLoadFail(NO_INTERNET));
    }
  }
}
