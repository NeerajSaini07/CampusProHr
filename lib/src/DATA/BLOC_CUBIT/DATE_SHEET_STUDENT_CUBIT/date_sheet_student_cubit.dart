import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/dateSheetStudentModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/dateSheetStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
part 'date_sheet_student_state.dart';

class DateSheetStudentCubit extends Cubit<DateSheetStudentState> {
  final DateSheetStudentRepository _repository;
  DateSheetStudentCubit(this._repository) : super(DateSheetStudentInitial());

  Future<void> dateSheetStudentCubitCall(
      Map<String, String?> dateSheetRequest) async {
    if (await isInternetPresent()) {
      try {
        emit(DateSheetStudentLoadInProgress());
        final data = await _repository.getDateSheet(dateSheetRequest);
        emit(DateSheetStudentLoadSuccess(data));
      } catch (e) {
        emit(DateSheetStudentLoadFail("$e"));
      }
    } else {
      emit(DateSheetStudentLoadFail(NO_INTERNET));
    }
  }
}
