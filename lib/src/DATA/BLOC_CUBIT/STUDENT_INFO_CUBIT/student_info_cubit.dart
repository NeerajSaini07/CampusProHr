import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentInfoRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'student_info_state.dart';

class StudentInfoCubit extends Cubit<StudentInfoState> {
  final StudentInfoRepository _repository;

  StudentInfoCubit(this._repository) : super(StudentInfoInitial());

  Future<void> studentInfoCubitCall(Map<String, String> studentData) async {
    if (await isInternetPresent()) {
      try {
        emit(StudentInfoLoadInProgress());
        final data = await _repository.getStudentInfo(studentData);
        emit(StudentInfoLoadSuccess(data));
      } catch (e) {
        emit(StudentInfoLoadFail("$e"));
      }
    } else {
      emit(StudentInfoLoadFail(NO_INTERNET));
    }
  }
}
