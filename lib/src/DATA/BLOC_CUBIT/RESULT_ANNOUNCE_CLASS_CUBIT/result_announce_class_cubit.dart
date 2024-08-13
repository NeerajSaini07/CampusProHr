import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/resultAnnounceClassRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'result_announce_class_state.dart';

class ResultAnnounceClassCubit extends Cubit<ResultAnnounceClassState> {
  final ResultAnnounceClassRepository repository;
  ResultAnnounceClassCubit(this.repository)
      : super(ResultAnnounceClassInitial());

  Future<void> resultAnnounceClassCubitCall(
      Map<String, dynamic> request) async {
    if (await isInternetPresent()) {
      try {
        emit(ResultAnnounceClassLoadInProgress());
        final data = await repository.getClass(request);
        emit(ResultAnnounceClassLoadSuccess(data));
      } catch (e) {
        emit(ResultAnnounceClassLoadFail('$e'));
      }
    } else {
      emit(ResultAnnounceClassLoadFail(NO_INTERNET));
    }
  }
}
