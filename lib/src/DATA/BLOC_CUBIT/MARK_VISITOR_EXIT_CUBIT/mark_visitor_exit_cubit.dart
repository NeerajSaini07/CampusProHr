import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/markVisitorExitRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'mark_visitor_exit_state.dart';

class MarkVisitorExitCubit extends Cubit<MarkVisitorExitState> {
  final MarkVisitorExitRepository _repository;
  MarkVisitorExitCubit(this._repository) : super(MarkVisitorExitInitial());

  Future<void> exitVisitor(Map<String, String?> payload, int num) async {
    if (await isInternetPresent()) {
      try {
        emit(MarkVisitorExitLoadInProgress());
        var data = await _repository.markExit(payload, num);
        emit(MarkVisitorExitLoadSuccess(data));
      } catch (e) {
        emit(MarkVisitorExitLoadFail('$e'));
      }
    } else {
      emit(MarkVisitorExitLoadFail(NO_INTERNET));
    }
  }
}
