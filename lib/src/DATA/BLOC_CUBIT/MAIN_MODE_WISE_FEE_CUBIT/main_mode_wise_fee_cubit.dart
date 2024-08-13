import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/mainModeWiseFeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/mainModeWiseFeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'main_mode_wise_fee_state.dart';

class MainModeWiseFeeCubit extends Cubit<MainModeWiseFeeState> {
  final MainModeWiseFeeRepository _repository;
  MainModeWiseFeeCubit(this._repository) : super(MainModeWiseFeeInitial());

  Future<void> mainModeWiseFeeCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(MainModeWiseFeeLoadInProgress());
        final data = await _repository.mainModeWiseFeeData(requestPayload);
        emit(MainModeWiseFeeLoadSuccess(data));
      } catch (e) {
        emit(MainModeWiseFeeLoadFail("$e"));
      }
    } else {
      emit(MainModeWiseFeeLoadFail(NO_INTERNET));
    }
  }
}
