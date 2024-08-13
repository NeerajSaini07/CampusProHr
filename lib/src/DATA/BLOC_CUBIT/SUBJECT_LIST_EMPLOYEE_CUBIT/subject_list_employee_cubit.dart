import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/subjectListEmployeeApi.dart';
import 'package:campus_pro/src/DATA/MODELS/SubjectListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/subjectListEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'subject_list_employee_state.dart';

class SubjectListEmployeeCubit extends Cubit<SubjectListEmployeeState> {
  final SubjectListEmployeeRepository _repository;
  SubjectListEmployeeCubit(this._repository)
      : super(SubjectListEmployeeInitial());

  Future<void> subjectListEmployeeCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(SubjectListEmployeeLoadInProgress());
        final data = await _repository.getSubject(userTypeData);
        emit(SubjectListEmployeeLoadSuccess(data));
      } catch (e) {
        emit(SubjectListEmployeeLoadFail('$e'));
      }
    } else {
      emit(SubjectListEmployeeLoadFail(NO_INTERNET));
    }
  }
}
