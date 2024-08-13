import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/circularStudentModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classRoomsStudentModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/circularStudentRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/classRoomsStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'classrooms_student_state.dart';

class ClassRoomsStudentCubit extends Cubit<ClassRoomsStudentState> {
  final ClassRoomsStudentRepository _repository;

  ClassRoomsStudentCubit(this._repository) : super(ClassRoomsStudentInitial());

  List<ClassRoomsStudentModel> classroomData = [];

  Future<void> classRoomsStudentCubitCall(
      Map<String, String?> classData) async {
    if (await isInternetPresent()) {
      try {
        emit(ClassRoomsStudentLoadInProgress());
        final data = await _repository.classRoomsData(classData);
        // classroomData.addAll(data);
        emit(ClassRoomsStudentLoadSuccess(data));
      } catch (e) {
        emit(ClassRoomsStudentLoadFail("$e"));
      }
    } else {
      emit(ClassRoomsStudentLoadFail(NO_INTERNET));
    }
  }
}
