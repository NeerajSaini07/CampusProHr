import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getClasswiseSubjectAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getClasswiseSubjectAdminReposiory.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_classwise_subject_admin_state.dart';

class GetClasswiseSubjectAdminCubit
    extends Cubit<GetClasswiseSubjectAdminState> {
  final GetClasswiseSubjectAdminRepository repository;
  GetClasswiseSubjectAdminCubit(this.repository)
      : super(GetClasswiseSubjectAdminInitial());

  Future<void> getClasswiseSubjectAdminCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetClasswiseSubjectAdminLoadInProgress());
        final data = await repository.getSubject(request);
        emit(GetClasswiseSubjectAdminLoadSuccess(data));
      } catch (e) {
        emit(GetClasswiseSubjectAdminLoadFail('$e'));
      }
    } else {
      emit(GetClasswiseSubjectAdminLoadFail(NO_INTERNET));
    }
  }
}
