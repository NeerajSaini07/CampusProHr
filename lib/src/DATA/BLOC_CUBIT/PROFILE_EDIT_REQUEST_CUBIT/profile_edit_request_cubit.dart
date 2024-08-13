import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/ProfileEditRequestRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'profile_edit_request_state.dart';

class ProfileEditRequestCubit extends Cubit<ProfileEditRequestState> {
  final ProfileEditRequestRepository _repository;
  ProfileEditRequestCubit(this._repository)
      : super(ProfileEditRequestInitial());

  Future<void> profileEditRequestCubitCall(
      Map<String, String> editData, File? _pickedImage) async {
    if (await isInternetPresent()) {
      try {
        emit(ProfileEditRequestLoadInProgress());
        final data =
            await _repository.profileEditRequest(editData, _pickedImage);
        emit(ProfileEditRequestLoadSuccess(data));
      } catch (e) {
        emit(ProfileEditRequestLoadFail("$e"));
      }
    } else {
      emit(ProfileEditRequestLoadFail(NO_INTERNET));
    }
  }
}
