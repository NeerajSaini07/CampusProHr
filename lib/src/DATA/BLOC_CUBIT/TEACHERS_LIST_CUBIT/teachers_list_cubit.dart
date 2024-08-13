import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/MODELS/teachersListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignTeacherRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/teachersListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'teachers_list_state.dart';

class TeachersListCubit extends Cubit<TeachersListState> {
  final TeachersListRepository _repository;
  TeachersListCubit(this._repository) : super(TeachersListInitial());

  Future<void> teachersListCubitCall(Map<String, String?> teacherData) async {
    if (await isInternetPresent()) {
      try {
        emit(TeachersListLoadInProgress());
        final data = await _repository.teacherList(teacherData);
        emit(TeachersListLoadSuccess(data));
      } catch (e) {
        emit(TeachersListLoadFail("$e"));
      }
    } else {
      emit(TeachersListLoadFail(NO_INTERNET));
    }
  }
}
