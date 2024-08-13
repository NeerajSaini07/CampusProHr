import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/log_in_repository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/updateEmailRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'update_email_state.dart';

class UpdateEmailCubit extends Cubit<UpdateEmailState> {
  //Dependency
  final UpdateEmailRepository _repository;

  UpdateEmailCubit(this._repository) : super(UpdateEmailInitial());

  Future<void> updateEmailCubitCall(Map<String, String> emailData) async {
    if (await isInternetPresent()) {
      try {
        emit(UpdateEmailLoadInProgress());
        final data = await _repository.updateEmail(emailData);
        emit(UpdateEmailLoadSuccess(data));
      } catch (e) {
        emit(UpdateEmailLoadFail("$e"));
      }
    } else {
      emit(UpdateEmailLoadFail(NO_INTERNET));
    }
  }
}
