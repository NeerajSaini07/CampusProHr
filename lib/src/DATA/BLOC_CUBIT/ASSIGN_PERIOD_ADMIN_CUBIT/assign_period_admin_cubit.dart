import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignPeriodAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'assign_period_admin_state.dart';

class AssignPeriodAdminCubit extends Cubit<AssignPeriodAdminState> {
  final AssignPeriodAdminRepository repository;
  AssignPeriodAdminCubit(this.repository) : super(AssignPeriodAdminInitial());

  Future<void> assignPeriodAdminCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(AssignPeriodAdminLoadInProgress());
        final data = await repository.assignPeriod(request);
        emit(AssignPeriodAdminLoadSuccess(data));
      } catch (e) {
        emit(AssignPeriodAdminLoadFail('$e'));
      }
    } else {
      emit(AssignPeriodAdminLoadFail(NO_INTERNET));
    }
  }
}
