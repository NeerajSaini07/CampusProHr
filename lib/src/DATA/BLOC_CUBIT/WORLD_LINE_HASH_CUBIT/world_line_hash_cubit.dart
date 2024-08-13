import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/worldLineHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/PAYMENT_GATEWAY_REPOSITORY/worldLineHashModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'world_line_hash_state.dart';

class WorldLineHashCubit extends Cubit<WorldLineHashState> {
  final WorldLineHashRepository _repository;
  WorldLineHashCubit(this._repository) : super(WorldLineHashInitial());

  Future<void> worldLineHashCubitCall(Map<String, String?> sendData) async {
    if (await isInternetPresent()) {
      try {
        emit(WorldLineHashLoadInProgress());
        final data = await _repository.worldLineHash(sendData);
        emit(WorldLineHashLoadSuccess(data));
      } catch (e) {
        emit(WorldLineHashLoadFail("$e"));
      }
    } else {
      emit(WorldLineHashLoadFail(NO_INTERNET));
    }
  }
}
