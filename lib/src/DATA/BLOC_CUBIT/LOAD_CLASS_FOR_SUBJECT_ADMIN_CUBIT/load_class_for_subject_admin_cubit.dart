import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/loadClassForSubjectAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/loadClassForSubjectAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'load_class_for_subject_admin_state.dart';

class LoadClassForSubjectAdminCubit
    extends Cubit<LoadClassForSubjectAdminState> {
  final LoadClassForSubjectAdminRepository repository;
  LoadClassForSubjectAdminCubit(this.repository)
      : super(LoadClassForSubjectAdminInitial());

  Future<void> loadClassForSubjectAdminCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(LoadClassForSubjectAdminLoadInProgress());
        final data = await repository.getClass(request);
        emit(LoadClassForSubjectAdminLoadSuccess(data));
      } catch (e) {
        emit(LoadClassForSubjectAdminLoadFail('$e'));
      }
    } else {
      emit(LoadClassForSubjectAdminLoadFail(NO_INTERNET));
    }
  }
}
