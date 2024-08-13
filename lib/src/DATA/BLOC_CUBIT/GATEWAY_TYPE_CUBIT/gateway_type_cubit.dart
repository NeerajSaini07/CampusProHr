import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/gatewayTypeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/PAYMENT_GATEWAY_REPOSITORY/gatewayTypeRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'gateway_type_state.dart';

class GatewayTypeCubit extends Cubit<GatewayTypeState> {
  final GatewayTypeRepository _repository;
  GatewayTypeCubit(this._repository) : super(GatewayTypeInitial());

  Future<void> gatewayTypeCubitCall(Map<String, String?> gatewayData) async {
    if (await isInternetPresent()) {
      try {
        emit(GatewayTypeLoadInProgress());
        final data = await _repository.gatewayType(gatewayData);
        emit(GatewayTypeLoadSuccess(data));
      } catch (e) {
        emit(GatewayTypeLoadFail("$e"));
      }
    } else {
      emit(GatewayTypeLoadFail(NO_INTERNET));
    }
  }
}
