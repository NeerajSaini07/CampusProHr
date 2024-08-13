import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveEmployeeImageRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_employee_image_state.dart';

class SaveEmployeeImageCubit extends Cubit<SaveEmployeeImageState> {
  final SaveEmployeeImageRepository _repository;
  SaveEmployeeImageCubit(this._repository)
      : super(SaveEmployeeImageInitial());

  Future<void> saveEmployeeImageCubitCall(Map<String, String> editData,File? _pickedImage) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveEmployeeImageLoadInProgress());
        final data =
            await _repository.saveEmployeeImage(editData,_pickedImage);
        emit(SaveEmployeeImageLoadSuccess(data));
      } catch (e) {
        emit(SaveEmployeeImageLoadFail("$e"));
      }
    } else {
      emit(SaveEmployeeImageLoadFail(NO_INTERNET));
    }
  }
}