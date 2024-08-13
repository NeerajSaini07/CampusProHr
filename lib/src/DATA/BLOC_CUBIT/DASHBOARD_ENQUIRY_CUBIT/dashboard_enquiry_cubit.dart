import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/dashboardEnquiryModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/dashboardEnquiryRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/dateSheetStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_enquiry_state.dart';

class DashboardEnquiryCubit extends Cubit<DashboardEnquiryState> {
  final DashboardEnquiryRepository _repository;
  DashboardEnquiryCubit(this._repository) : super(DashboardEnquiryInitial());

  Future<void> dashboardEnquiryCubitCall(
      Map<String, String?> dashboardEnquiryData) async {
    if (await isInternetPresent()) {
      try {
        emit(DashboardEnquiryLoadInProgress());
        final data = await _repository.dashboardEnquiry(dashboardEnquiryData);
        emit(DashboardEnquiryLoadSuccess(data));
      } catch (e) {
        emit(DashboardEnquiryLoadFail("$e"));
      }
    } else {
      emit(DashboardEnquiryLoadFail(NO_INTERNET));
    }
  }
}
