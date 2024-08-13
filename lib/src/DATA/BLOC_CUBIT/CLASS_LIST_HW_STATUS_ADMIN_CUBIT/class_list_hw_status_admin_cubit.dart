import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classListHwStatusAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/classListHwStatusAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'class_list_hw_status_admin_state.dart';

class ClassListHwStatusAdminCubit extends Cubit<ClassListHwStatusAdminState> {
  final ClassListHwStatusAdminRepository repository;
  ClassListHwStatusAdminCubit(this.repository)
      : super(ClassListHwStatusAdminInitial());

  Future<void> classListHwStatusAdminCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(ClassListHwStatusAdminLoadInProgress());
        final data = await repository.getClass(userTypeData);
        emit(ClassListHwStatusAdminLoadSuccess(data));
      } catch (e) {
        emit(ClassListHwStatusAdminLoadFail('$e'));
      }
    } else {
      emit(ClassListHwStatusAdminLoadFail(NO_INTERNET));
    }
  }
}
