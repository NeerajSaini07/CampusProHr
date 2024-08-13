import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/loadAllottedSubjectsModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/loadAllottedSubjectsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'load_allotted_subject_state.dart';

class LoadAllottedSubjectCubit extends Cubit<LoadAllottedSubjectState> {
  final LoadAllottedSubjectsRepository repository;
  LoadAllottedSubjectCubit(this.repository)
      : super(LoadAllottedSubjectInitial());

  Future<void> loadAllottedSubjectCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(LoadAllottedSubjectLoadInProgress());
        final data = await repository.getAllotedSubject(request);
        emit(LoadAllottedSubjectLoadSuccess(data));
      } catch (e) {
        emit(LoadAllottedSubjectLoadFail('$e'));
      }
    } else {
      emit(LoadAllottedSubjectLoadFail(NO_INTERNET));
    }
  }
}
