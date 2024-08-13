import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusDetailModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/schoolBusDetailRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'school_bus_detail_state.dart';

class SchoolBusDetailCubit extends Cubit<SchoolBusDetailState> {
  final SchoolBusDetailRepository _repository;
  SchoolBusDetailCubit(this._repository) : super(SchoolBusDetailInitial());

  Future<void> schoolBusDetailCubitCall(Map<String, String?> busData) async {
    if (await isInternetPresent()) {
      try {
        emit(SchoolBusDetailLoadInProgress());
        final data = await _repository.busInfoData(busData);
        emit(SchoolBusDetailLoadSuccess(data));
      } catch (e) {
        emit(SchoolBusDetailLoadFail("$e"));
      }
    } else {
      emit(SchoolBusDetailLoadFail(NO_INTERNET));
    }
  }
}
