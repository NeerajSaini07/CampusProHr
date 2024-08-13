import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/techProcessHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/PAYMENT_GATEWAY_REPOSITORY/techProcessHashRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'tech_process_hash_state.dart';

class TechProcessHashCubit extends Cubit<TechProcessHashState> {
  final TechProcessHashRepository _repository;
  TechProcessHashCubit(this._repository) : super(TechProcessHashInitial());

  Future<void> techProcessHashCubitCall(Map<String, String?> sendData) async {
    if (await isInternetPresent()) {
      try {
        emit(TechProcessHashLoadInProgress());
        final data = await _repository.techProcessHash(sendData);
        emit(TechProcessHashLoadSuccess(data));
      } catch (e) {
        emit(TechProcessHashLoadFail("$e"));
      }
    } else {
      emit(TechProcessHashLoadFail(NO_INTERNET));
    }
  }
}
