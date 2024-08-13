import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/ccAvenueHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/PAYMENT_GATEWAY_REPOSITORY/ccAvenueHashRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'c_c_avenue_hash_state.dart';

class CCAvenueHashCubit extends Cubit<CCAvenueHashState> {
  final CCAvenueHashRepository _repository;
  CCAvenueHashCubit(this._repository) : super(CCAvenueHashInitial());

  Future<void> ccAvenueHashCubitCall(Map<String, String?> sendData) async {
    if (await isInternetPresent()) {
      try {
        emit(CCAvenueHashLoadInProgress());
        final data = await _repository.ccAvenueHash(sendData);
        emit(CCAvenueHashLoadSuccess(data));
      } catch (e) {
        emit(CCAvenueHashLoadFail("$e"));
      }
    } else {
      emit(CCAvenueHashLoadFail(NO_INTERNET));
    }
  }
}
