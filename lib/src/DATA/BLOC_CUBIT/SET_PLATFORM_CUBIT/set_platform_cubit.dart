import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/setPlateformRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'set_platform_state.dart';

class SetPlatformCubit extends Cubit<SetPlatformState> {
  final SetPlateformRepository _repository;

  SetPlatformCubit(this._repository) : super(SetPlatformInitial());

  Future<void> setPlatformCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(SetPlatformLoadInProgress());
        var data = await _repository.getPlatform(request);
        emit(SetPlatformLoadSuccess(data));
      } catch (e) {
        emit(SetPlatformLoadFail('$e'));
      }
    } else {
      emit(SetPlatformLoadFail(NO_INTERNET));
    }
  }
}
