import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getSubjectAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getSubjectAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_subject_admin_state.dart';

class GetSubjectAdminCubit extends Cubit<GetSubjectAdminState> {
  final GetSubjectAdminRepository repository;
  GetSubjectAdminCubit(this.repository) : super(GetSubjectAdminInitial());

  Future<void> getSubjectAdminCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetSubjectAdminLoadInProgress());
        final data = await repository.getSubject(request);
        emit(GetSubjectAdminLoadSuccess(data));
      } catch (e) {
        emit(GetSubjectAdminLoadFail('$e'));
      }
    } else {
      emit(GetSubjectAdminLoadFail(NO_INTERNET));
    }
  }
}
