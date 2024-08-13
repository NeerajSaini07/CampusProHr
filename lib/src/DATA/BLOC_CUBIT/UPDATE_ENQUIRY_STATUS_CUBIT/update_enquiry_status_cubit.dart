import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/updateEnquiryStatusRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/account_type_repository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

part 'update_enquiry_status_state.dart';

class UpdateEnquiryStatusCubit extends Cubit<UpdateEnquiryStatusState> {
  final UpdateEnquiryStatusRepository _repository;

  UpdateEnquiryStatusCubit(this._repository)
      : super(UpdateEnquiryStatusInitial());

  Future<void> updateEnquiryStatusCubitCall(
      Map<String, String> updateData) async {
    if (await isInternetPresent()) {
      try {
        emit(UpdateEnquiryStatusLoadInProgress());
        final data = await _repository.updateEnquiryStatus(updateData);
        emit(UpdateEnquiryStatusLoadSuccess(data));
      } catch (e) {
        emit(UpdateEnquiryStatusLoadFail("$e"));
      }
    } else {
      emit(UpdateEnquiryStatusLoadFail(NO_INTERNET));
    }
  }
}
