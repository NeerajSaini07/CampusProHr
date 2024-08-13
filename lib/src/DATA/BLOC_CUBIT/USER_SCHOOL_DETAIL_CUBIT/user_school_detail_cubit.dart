import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/userSchoolDetailModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/userSchoolDetailRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'user_school_detail_state.dart';

class UserSchoolDetailCubit extends Cubit<UserSchoolDetailState> {
  final UserSchoolDetailRepository _repository;

  UserSchoolDetailCubit(this._repository) : super(UserSchoolDetailInitial());

  Future<void> userSchoolDetailCubitCall(Map<String, String> userData) async {
    if (await isInternetPresent()) {
      try {
        emit(UserSchoolDetailLoadInProgress());
        final data = await _repository.getUserSchool(userData);
        emit(UserSchoolDetailLoadSuccess(data));
      } catch (e) {
        emit(UserSchoolDetailLoadFail("$e"));
      }
    } else {
      emit(UserSchoolDetailLoadFail(NO_INTERNET));
    }
  }
}
