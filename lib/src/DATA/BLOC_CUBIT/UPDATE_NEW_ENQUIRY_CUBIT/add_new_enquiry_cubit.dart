import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/addNewEnquiryRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/account_type_repository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

part 'add_new_enquiry_state.dart';

class AddNewEnquiryCubit extends Cubit<AddNewEnquiryState> {
  final AddNewEnquiryRepository _repository;

  AddNewEnquiryCubit(this._repository) : super(AddNewEnquiryInitial());

  Future<void> addNewEnquiry(Map<String, String> enquiryData) async {
    if (await isInternetPresent()) {
      try {
        emit(AddNewEnquiryLoadInProgress());
        final data = await _repository.addNewEnquiry(enquiryData);
        emit(AddNewEnquiryLoadSuccess(data));
      } catch (e) {
        emit(AddNewEnquiryLoadFail("$e"));
      }
    } else {
      emit(AddNewEnquiryLoadFail(NO_INTERNET));
    }
  }
}
