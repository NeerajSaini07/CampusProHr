import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getSelectClassTeacherRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_select_class_teacher_state.dart';

class GetSelectClassTeacherCubit extends Cubit<GetSelectClassTeacherState> {
  final GetSelectClassTeacherRepository repository;
  GetSelectClassTeacherCubit(this.repository)
      : super(GetSelectClassTeacherInitial());

  Future<void> getSelectClassTeacherCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetSelectClassTeacherLoadInProgress());
        final data = await repository.getClassTeacherSelect(request);
        emit(GetSelectClassTeacherLoadSuccess(data));
      } catch (e) {
        emit(GetSelectClassTeacherLoadFail('$e'));
      }
    } else {
      emit(GetSelectClassTeacherLoadFail(NO_INTERNET));
    }
  }
}
