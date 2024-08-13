import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/removeAllottedSubjectsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'remove_allotted_subject_state.dart';

class RemoveAllottedSubjectCubit extends Cubit<RemoveAllottedSubjectState> {
  final RemoveAllottedSubjectsRepository repository;
  RemoveAllottedSubjectCubit(this.repository)
      : super(RemoveAllottedSubjectInitial());

  Future<void> removeAllottedSubjectCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(RemoveAllottedSubjectLoadInProgress());
        final data = await repository.removeSubject(request);
        emit(RemoveAllottedSubjectLoadSuccess(data));
      } catch (e) {
        emit(RemoveAllottedSubjectLoadFail('$e'));
      }
    } else {
      emit(RemoveAllottedSubjectLoadFail(NO_INTERNET));
    }
  }
}
