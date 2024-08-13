import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classesForCoordinatorModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/classesForCoordinatorRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'classes_for_coordinator_state.dart';

class ClassesForCoordinatorCubit extends Cubit<ClassesForCoordinatorState> {
  final ClassesForCoordinatorRepository _repository;
  ClassesForCoordinatorCubit(this._repository)
      : super(ClassesForCoordinatorInitial());

  Future<void> classesForCoordinatorCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(ClassesForCoordinatorLoadInProgress());
        var data = await _repository.getClass(request);
        emit(ClassesForCoordinatorLoadSuccess(data));
      } catch (e) {
        emit(ClassesForCoordinatorLoadFail('$e'));
      }
    } else {
      emit(ClassesForCoordinatorLoadFail(NO_INTERNET));
    }
  }
}
