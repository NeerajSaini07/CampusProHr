import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/markSheetModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/markSheetStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'mark_sheet_student_state.dart';

class MarkSheetStudentCubit extends Cubit<MarkSheetStudentState> {
  final MarkSheetStudentRepository _repository;
  MarkSheetStudentCubit(this._repository) : super(MarkSheetStudentInitial());

  Future<void> loadMarkSheetCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(MarkSheetStudentLoadInProgress());
        final data = await _repository.loadMarkSheetData(requestPayload);
        emit(MarkSheetStudentLoadSuccess(data));
      } catch (e) {
        emit(MarkSheetStudentLoadFail("$e"));
      }
    } else {
      emit(MarkSheetStudentLoadFail(NO_INTERNET));
    }
  }
}
