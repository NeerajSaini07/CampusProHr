import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classListPrevHwNotDoneStatusModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/classListPrevHwNotDoneStatusRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'class_list_prev_hw_not_done_status_state.dart';

class ClassListPrevHwNotDoneStatusCubit
    extends Cubit<ClassListPrevHwNotDoneStatusState> {
  final ClassListPrevHwNotDoneStatusRepository repository;
  ClassListPrevHwNotDoneStatusCubit(this.repository)
      : super(ClassListPrevHwNotDoneStatusInitial());

  Future<void> classListPrevHwNotDoneStatusCubitCall(
      Map<String, String?> sendingClassRequest) async {
    if (await isInternetPresent()) {
      try {
        emit(ClassListPrevHwNotDoneStatusLoadInProgress());
        final data = await repository.getClass(sendingClassRequest);
        emit(ClassListPrevHwNotDoneStatusLoadSuccess(data));
      } catch (e) {
        emit(ClassListPrevHwNotDoneStatusLoadFail('$e'));
      }
    } else {
      emit(ClassListPrevHwNotDoneStatusLoadFail('$NO_INTERNET'));
    }
  }
}
