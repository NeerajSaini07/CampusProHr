import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/cceAttendanceClassDataModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/cceAttendanceClassDataRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'cce_attendance_class_data_state.dart';

class CceAttendanceClassDataCubit extends Cubit<CceAttendanceClassDataState> {
  final CceAttendanceClassDataRepository _repository;
  CceAttendanceClassDataCubit(this._repository)
      : super(CceAttendanceClassDataInitial());

  Future<void> cceAttendanceClassDataCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(CceAttendanceClassDataLoadInProgress());
        var data = await _repository.getClassData(request);
        emit(CceAttendanceClassDataLoadSuccess(data));
      } catch (e) {
        emit(CceAttendanceClassDataLoadFail('$e'));
      }
    } else {
      emit(CceAttendanceClassDataLoadFail(NO_INTERNET));
    }
  }
}
