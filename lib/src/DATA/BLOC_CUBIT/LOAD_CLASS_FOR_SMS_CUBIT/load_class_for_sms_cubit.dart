import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/loadClassForSmsModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/loadClassForSmsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'load_class_for_sms_state.dart';

class LoadClassForSmsCubit extends Cubit<LoadClassForSmsState> {
  final LoadClassForSmsRepository repository;
  LoadClassForSmsCubit(this.repository) : super(LoadClassForSmsInitial());

  Future<void> loadClassForSmsCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(LoadClassForSmsLoadInProgress());
        final data = await repository.getClass(request);
        emit(LoadClassForSmsLoadSuccess(data));
      } catch (e) {
        emit(LoadClassForSmsLoadFail('$e'));
      }
    } else {
      emit(LoadClassForSmsLoadFail(NO_INTERNET));
    }
  }
}
