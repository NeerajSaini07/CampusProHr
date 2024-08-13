import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusInfoModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/schoolBusInfoRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'school_bus_info_state.dart';

class SchoolBusInfoCubit extends Cubit<SchoolBusInfoState> {
  final SchoolBusInfoRepository _repository;
  SchoolBusInfoCubit(this._repository) : super(SchoolBusInfoInitial());

  Future<void> schoolBusInfoCubitCall(Map<String, String?> busData) async {
    if (await isInternetPresent()) {
      try {
        emit(SchoolBusInfoLoadInProgress());
        final data = await _repository.busInfoData(busData);
        emit(SchoolBusInfoLoadSuccess(data));
      } catch (e) {
        emit(SchoolBusInfoLoadFail("$e"));
      }
    } else {
      emit(SchoolBusInfoLoadFail(NO_INTERNET));
    }
  }
}