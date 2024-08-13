import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examSelectedListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/examSelectedListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'exam_selected_list_state.dart';

class ExamSelectedListCubit extends Cubit<ExamSelectedListState> {
  final ExamSelectedListRepository _repository;
  ExamSelectedListCubit(this._repository) : super(ExamSelectedListInitial());

  Future<void> examSelectedListCubitCall(Map<String, String?> feeData) async {
    if (await isInternetPresent()) {
      try {
        emit(ExamSelectedListLoadInProgress());
        final data = await _repository.examSelectedList(feeData);
        emit(ExamSelectedListLoadSuccess(data));
      } catch (e) {
        emit(ExamSelectedListLoadFail("$e"));
      }
    } else {
      emit(ExamSelectedListLoadFail(NO_INTERNET));
    }
  }
}
