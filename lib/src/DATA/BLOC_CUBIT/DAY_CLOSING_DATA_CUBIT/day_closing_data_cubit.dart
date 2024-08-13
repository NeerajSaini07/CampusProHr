import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/dayClosingDataModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/dayClosingDataRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'day_closing_data_state.dart';

class DayClosingDataCubit extends Cubit<DayClosingDataState> {
  final DayClosingDataRepository _repository;
  DayClosingDataCubit(this._repository) : super(DayClosingDataInitial());

  Future<void> dayClosingDataCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(DayClosingDataLoadInProgress());
        final data = await _repository.dayClosingDataData(requestPayload);
        emit(DayClosingDataLoadSuccess(data));
      } catch (e) {
        emit(DayClosingDataLoadFail("$e"));
      }
    } else {
      emit(DayClosingDataLoadFail(NO_INTERNET));
    }
  }
}
