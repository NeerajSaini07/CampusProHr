import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/deleteCircularRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'delete_circular_state.dart';

class DeleteCircularCubit extends Cubit<DeleteCircularState> {
  //Dependency
  final DeleteCircularRepository _repository;

  DeleteCircularCubit(this._repository) : super(DeleteCircularInitial());

  Future<void> deleteCircularCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(DeleteCircularLoadInProgress());
        final data = await _repository.deleteData(request);
        emit(DeleteCircularLoadSuccess(data));
      } catch (e) {
        emit(DeleteCircularLoadFail("$e"));
      }
    } else {
      emit(DeleteCircularLoadFail(NO_INTERNET));
    }
  }
}