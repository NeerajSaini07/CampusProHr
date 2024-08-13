import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/visitorListTodayModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/visitorListTodayGatePassRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'visitor_list_gate_pass_state.dart';

class VisitorListGatePassCubit extends Cubit<VisitorListGatePassState> {
  final VisitorListTodayGatePassRepository _repository;
  VisitorListGatePassCubit(this._repository)
      : super(VisitorListGatePassInitial());

  Future<void> visitorListGatePassCubitCall(
      Map<String, String?> payload) async {
    if (await isInternetPresent()) {
      try {
        emit(VisitorListGatePassLoadInProgress());
        var data = await _repository.getList(payload);
        emit(VisitorListGatePassLoadSuccess(data));
      } catch (e) {
        emit(VisitorListGatePassLoadFail('$e'));
      }
    } else {
      emit(VisitorListGatePassLoadFail(NO_INTERNET));
    }
  }
}
