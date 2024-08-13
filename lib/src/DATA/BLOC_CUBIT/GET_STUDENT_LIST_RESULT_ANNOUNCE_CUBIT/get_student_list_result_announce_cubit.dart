import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getStudentListResultAnnounceModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getStudentListResultAnnounceRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_student_list_result_announce_state.dart';

class GetStudentListResultAnnounceCubit
    extends Cubit<GetStudentListResultAnnounceState> {
  final GetStudentListResultAnnounceRepository _repository;
  GetStudentListResultAnnounceCubit(this._repository)
      : super(GetStudentListResultAnnounceInitial());

  Future<void> getStudentListResultAnnounceCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetStudentListResultAnnounceLoadInProgress());
        var data = await _repository.getStudentList(request);
        emit(GetStudentListResultAnnounceLoadSuccess(data));
      } catch (e) {
        emit(GetStudentListResultAnnounceLoadFail('$e'));
      }
    } else {
      emit(GetStudentListResultAnnounceLoadFail(NO_INTERNET));
    }
  }
}
