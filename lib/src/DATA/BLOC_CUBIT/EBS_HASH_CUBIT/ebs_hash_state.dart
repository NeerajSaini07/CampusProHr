part of 'ebs_hash_cubit.dart';

abstract class EbsHashState extends Equatable {
  const EbsHashState();
}

class EbsHashInitial extends EbsHashState {
  @override
  List<Object> get props => [];
}

class EbsHashLoadInProgress extends EbsHashState {
  @override
  List<Object> get props => [];
}

class EbsHashLoadSuccess extends EbsHashState {
  final List<EbsHashModel> ebsData;

  EbsHashLoadSuccess(this.ebsData);
  @override
  List<Object> get props => [ebsData];
}

class EbsHashLoadFail extends EbsHashState {
  final String failReason;

  EbsHashLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
