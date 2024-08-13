import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/classListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'class_list_state.dart';

class ClassListCubit extends Cubit<ClassListState> {
  final ClassListRepository _repository;
  ClassListCubit(this._repository) : super(ClassListInitial());

  Future<void> classListCubitCall(Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(ClassListLoadInProgress());
        final data = await _repository.classList(requestPayload);
        emit(ClassListLoadSuccess(data));
      } catch (e) {
        emit(ClassListLoadFail("$e"));
      }
    } else {
      emit(ClassListLoadFail(NO_INTERNET));
    }
  }
}
