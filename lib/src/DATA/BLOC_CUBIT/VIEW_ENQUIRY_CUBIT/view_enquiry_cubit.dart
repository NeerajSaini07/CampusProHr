import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/viewEnquiryModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/viewEnquiryRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/account_type_repository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

part 'view_enquiry_state.dart';

class ViewEnquiryCubit extends Cubit<ViewEnquiryState> {
  final ViewEnquiryRepository _repository;

  ViewEnquiryCubit(this._repository) : super(ViewEnquiryInitial());

  Future<void> viewEnquiryCubitCall(Map<String, String> viewData) async {
    if (await isInternetPresent()) {
      try {
        emit(ViewEnquiryLoadInProgress());
        final data = await _repository.viewEnquiry(viewData);
        emit(ViewEnquiryLoadSuccess(data));
      } catch (e) {
        emit(ViewEnquiryLoadFail("$e"));
      }
    } else {
      emit(ViewEnquiryLoadFail(NO_INTERNET));
    }
  }
}
