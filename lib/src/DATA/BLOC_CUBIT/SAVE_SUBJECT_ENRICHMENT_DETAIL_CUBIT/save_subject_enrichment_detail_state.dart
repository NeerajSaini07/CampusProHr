part of 'save_subject_enrichment_detail_cubit.dart';

abstract class SaveSubjectEnrichmentDetailState extends Equatable {
  const SaveSubjectEnrichmentDetailState();
}

class SaveSubjectEnrichmentDetailInitial
    extends SaveSubjectEnrichmentDetailState {
  @override
  List<Object> get props => [];
}

class SaveSubjectEnrichmentDetailLoadInProgress
    extends SaveSubjectEnrichmentDetailState {
  @override
  List<Object> get props => [];
}

class SaveSubjectEnrichmentDetailLoadSuccess
    extends SaveSubjectEnrichmentDetailState {
  final String result;
  SaveSubjectEnrichmentDetailLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class SaveSubjectEnrichmentDetailLoadFail
    extends SaveSubjectEnrichmentDetailState {
  final String failReason;
  SaveSubjectEnrichmentDetailLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
