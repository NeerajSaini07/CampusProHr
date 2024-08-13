import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/profileStudentModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/profileStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'profile_student_state.dart';

class ProfileStudentCubit extends Cubit<ProfileStudentState> {
  final ProfileStudentRepository _repository;

  ProfileStudentCubit(this._repository) : super(ProfileStudentInitial());
  Future<void> profileStudentCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(ProfileStudentLoadInProgress());
        final data = await _repository.profileData(requestPayload);
        emit(ProfileStudentLoadSuccess(data));
      } catch (e) {
        emit(ProfileStudentLoadFail("$e"));
      }
    } else {
      emit(ProfileStudentLoadFail(NO_INTERNET));
    }
  }
}
