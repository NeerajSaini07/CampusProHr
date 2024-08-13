import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/dashboardAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/dashboardAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_admin_state.dart';

class DashboardAdminCubit extends Cubit<DashboardAdminState> {
  //Dependency
  final DashboardAdminRepository _repository;

  DashboardAdminCubit(this._repository) : super(DashboardAdminInitial());

  Future<void> dashboardAdminCubitCall(
      Map<String, String?> dashboardData) async {
    if (await isInternetPresent()) {
      try {
        emit(DashboardAdminLoadInProgress());
        final data = await _repository.showDashboardAdminData(dashboardData);
        emit(DashboardAdminLoadSuccess(data));
      } catch (e) {
        emit(DashboardAdminLoadFail("$e"));
      }
    } else {
      emit(DashboardAdminLoadFail(NO_INTERNET));
    }
  }
}
