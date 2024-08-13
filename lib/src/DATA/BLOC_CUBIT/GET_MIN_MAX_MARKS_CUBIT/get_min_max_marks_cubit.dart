import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getMinMaxmarksModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getMinmarksRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_min_max_marks_state.dart';

class GetMinMaxMarksCubit extends Cubit<GetMinMaxMarksState> {
  final GetMinMaxmarksRepository repository;
  GetMinMaxMarksCubit(this.repository) : super(GetMinMaxMarksInitial());

  Future<void> getMinMaxMarksCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetMinMaxMarksLoadInProgress());
        final data = await repository.getMinMaxMarks(request);
        emit(GetMinMaxMarksLoadSuccess(data));
      } catch (e) {
        emit(GetMinMaxMarksLoadFail('$e'));
      }
    } else {
      emit(GetMinMaxMarksLoadFail('$NO_INTERNET'));
    }
  }
}
