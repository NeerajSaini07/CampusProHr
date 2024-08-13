import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEnquiryModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/classListEnquiryRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/classListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'class_list_enquiry_state.dart';

class ClassListEnquiryCubit extends Cubit<ClassListEnquiryState> {
  final ClassListEnquiryRepository _repository;
  ClassListEnquiryCubit(this._repository) : super(ClassListEnquiryInitial());

  Future<void> classListEnquiryCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(ClassListEnquiryLoadInProgress());
        final data = await _repository.classList(requestPayload);
        emit(ClassListEnquiryLoadSuccess(data));
      } catch (e) {
        emit(ClassListEnquiryLoadFail("$e"));
      }
    } else {
      emit(ClassListEnquiryLoadFail(NO_INTERNET));
    }
  }
}
