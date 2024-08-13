import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/restrictionPageModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/restrictionPageRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'restriction_page_state.dart';

class RestrictionPageCubit extends Cubit<RestrictionPageState> {
  //Dependency
  final RestrictionPageRepository _repository;

  RestrictionPageCubit(this._repository) : super(RestrictionPageInitial());

  Future<void> restrictionPageCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(RestrictionPageLoadInProgress());
        final data = await _repository.restrictionPage(request);
        emit(RestrictionPageLoadSuccess(data));
      } catch (e) {
        emit(RestrictionPageLoadFail("$e"));
      }
    } else {
      emit(RestrictionPageLoadFail(NO_INTERNET));
    }
  }
}