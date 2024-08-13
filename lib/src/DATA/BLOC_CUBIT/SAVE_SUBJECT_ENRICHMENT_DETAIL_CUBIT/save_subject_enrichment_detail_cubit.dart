import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveSubjectEnrichmentDetailsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'save_subject_enrichment_detail_state.dart';

class SaveSubjectEnrichmentDetailCubit
    extends Cubit<SaveSubjectEnrichmentDetailState> {
  final SaveSubjectEnrichmentDetailsRepository _repository;
  SaveSubjectEnrichmentDetailCubit(this._repository)
      : super(SaveSubjectEnrichmentDetailInitial());

  Future<void> saveSubjectEnrichmentDetailCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveSubjectEnrichmentDetailLoadInProgress());
        var data = await _repository.saveSubjectDetail(request);
        emit(SaveSubjectEnrichmentDetailLoadSuccess(data));
      } catch (e) {
        emit(SaveSubjectEnrichmentDetailLoadFail('$e'));
      }
    } else {
      emit(SaveSubjectEnrichmentDetailLoadFail(NO_INTERNET));
    }
  }
}
