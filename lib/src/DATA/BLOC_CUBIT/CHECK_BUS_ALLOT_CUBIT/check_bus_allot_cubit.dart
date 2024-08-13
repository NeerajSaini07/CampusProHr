import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/checkBusAllotRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'check_bus_allot_state.dart';

class CheckBusAllotCubit extends Cubit<CheckBusAllotState> {
  final CheckBusAllotRepository repository;
  CheckBusAllotCubit(this.repository) : super(CheckBusAllotInitial());

  Future<void> checkBusAllotCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(CheckBusAllotLoadInProgress());
        var data = await repository.checkBus(request);
        emit(CheckBusAllotLoadSuccess(data));
      } catch (e) {
        emit(CheckBusAllotLoadFail('$e'));
      }
    } else {
      emit(CheckBusAllotLoadFail(NO_INTERNET));
    }
  }
}
