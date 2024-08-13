import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SUBJECT_LIST_EMPLOYEE_CUBIT/subject_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/weekPlanSubjectListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/weekPlanSubjectListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'week_plan_subject_list_state.dart';

class WeekPlanSubjectListCubit extends Cubit<WeekPlanSubjectListState> {
  final WeekPlanSubjectListRepository repository;
  WeekPlanSubjectListCubit(this.repository)
      : super(WeekPlanSubjectListInitial());

  Future<void> weekPlanSubjectListCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(WeekPlanSubjectListLoadInProgress());
        final data = await repository.getSubject(userTypeData);
        emit(WeekPlanSubjectListLoadSuccess(data));
      } catch (e) {
        emit(WeekPlanSubjectListLoadFail('$e'));
      }
    } else {
      emit(WeekPlanSubjectListLoadFail(NO_INTERNET));
    }
  }
}
