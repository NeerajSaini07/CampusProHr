import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/schoolBusListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'school_bus_list_state.dart';

class SchoolBusListCubit extends Cubit<SchoolBusListState> {
  final SchoolBusListRepository _repository;
  SchoolBusListCubit(this._repository) : super(SchoolBusListInitial());

  Future<void> schoolBusListCubitCall(Map<String, String?> busData) async {
    if (await isInternetPresent()) {
      try {
        emit(SchoolBusListLoadInProgress());
        final data = await _repository.busInfoData(busData);
        emit(SchoolBusListLoadSuccess(data));
      } catch (e) {
        emit(SchoolBusListLoadFail("$e"));
      }
    } else {
      emit(SchoolBusListLoadFail(NO_INTERNET));
    }
  }
}
