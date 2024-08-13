import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getGradeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getGradeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_grade_state.dart';

class GetGradeCubit extends Cubit<GetGradeState> {
  final GetGradeRepository repository;
  GetGradeCubit(this.repository) : super(GetGradeInitial());

  Future<void> getGradeCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetGradeLoadInProgress());
        var data = await repository.getGrade(request);
        emit(GetGradeLoadSuccess(data));
      } catch (e) {
        emit(GetGradeLoadFail('$e'));
      }
    } else {
      emit(GetGradeLoadFail(NO_INTERNET));
    }
  }
}
