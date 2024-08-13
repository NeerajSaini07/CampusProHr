import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/gatePassMeetToModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/gatePassMeetToRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'gate_pass_meet_to_state.dart';

class GatePassMeetToCubit extends Cubit<GatePassMeetToState> {
  final GatePassMeetToRepository _repository;
  GatePassMeetToCubit(this._repository) : super(GatePassMeetToInitial());

  Future<void> gatePassMeetToCubitCall(
      Map<String, String?> payload, int? num) async {
    if (await isInternetPresent()) {
      try {
        emit(GatePassMeetToLoadInProgress());
        var data = await _repository.getData(payload, num);
        emit(GatePassMeetToLoadSuccess(data));
      } catch (e) {
        emit(GatePassMeetToLoadFail('$e'));
      }
    } else {
      emit(GatePassMeetToLoadFail(NO_INTERNET));
    }
  }
}
