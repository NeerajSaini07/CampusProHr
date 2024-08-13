import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/deleteCoordinatorRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'delete_coordinator_state.dart';

class DeleteCoordinatorCubit extends Cubit<DeleteCoordinatorState> {
  final DeleteCoordinatorRepository _repository;
  DeleteCoordinatorCubit(this._repository) : super(DeleteCoordinatorInitial());

  Future<void> deleteCoordinatorCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(DeleteCoordinatorLoadInProgress());
        var data = await _repository.deleteCoordinator(request);
        emit(DeleteCoordinatorLoadSuccess(data));
      } catch (e) {
        emit(DeleteCoordinatorLoadFail('$e'));
      }
    } else {
      emit(DeleteCoordinatorLoadFail(NO_INTERNET));
    }
  }
}
