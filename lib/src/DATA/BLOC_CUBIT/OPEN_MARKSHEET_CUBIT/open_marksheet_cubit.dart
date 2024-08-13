import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/openMarksheetRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'open_marksheet_state.dart';

class OpenMarksheetCubit extends Cubit<OpenMarksheetState> {
  final OpenMarksheetRepository _repository;
  OpenMarksheetCubit(this._repository) : super(OpenMarksheetInitial());

  Future<void> openMarksheetCubitCall(
      Map<String, String> marksheetData) async {
    if (await isInternetPresent()) {
      try {
        emit(OpenMarksheetLoadInProgress());
        final data = await _repository.openMarksheet(marksheetData);
        emit(OpenMarksheetLoadSuccess(data));
      } catch (e) {
        emit(OpenMarksheetLoadFail("$e"));
      }
    } else {
      emit(OpenMarksheetLoadFail(NO_INTERNET));
    }
  }
}