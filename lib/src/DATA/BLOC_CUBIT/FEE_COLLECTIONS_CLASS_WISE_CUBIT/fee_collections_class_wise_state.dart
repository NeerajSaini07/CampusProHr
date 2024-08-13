part of 'fee_collections_class_wise_cubit.dart';

abstract class FeeCollectionsClassWiseState extends Equatable {
  const FeeCollectionsClassWiseState();
}

class FeeCollectionsClassWiseInitial extends FeeCollectionsClassWiseState {
  @override
  List<Object> get props => [];
}

class FeeCollectionsClassWiseLoadInProgress extends FeeCollectionsClassWiseState {
  @override
  List<Object> get props => [];
}

class FeeCollectionsClassWiseLoadSuccess extends FeeCollectionsClassWiseState {
  final List<FeeCollectionsClassWiseModel> feeCollectionsClassWise;

  FeeCollectionsClassWiseLoadSuccess(this.feeCollectionsClassWise);
  @override
  List<Object> get props => [feeCollectionsClassWise];
}

class FeeCollectionsClassWiseLoadFail extends FeeCollectionsClassWiseState {
  final String failReason;

  FeeCollectionsClassWiseLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
