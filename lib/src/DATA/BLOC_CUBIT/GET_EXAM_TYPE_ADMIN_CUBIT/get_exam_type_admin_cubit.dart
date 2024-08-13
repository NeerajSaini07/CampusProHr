import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getExamTypeAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getExamTypeAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_exam_type_admin_state.dart';

class GetExamTypeAdminCubit extends Cubit<GetExamTypeAdminState> {
  final GetExamTypeAdminRepository _repository;

  GetExamTypeAdminCubit(this._repository) : super(GetExamTypeAdminInitial());

  Future<void> getExamTypeAdminCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetExamTypeAdminLoadInProgress());
        final data = await _repository.getExam(request);
        emit(GetExamTypeAdminLoadSuccess(data));
      } catch (e) {
        emit(GetExamTypeAdminLoadFail('$e'));
      }
    } else {
      emit(GetExamTypeAdminLoadFail(NO_INTERNET));
    }
  }
}
