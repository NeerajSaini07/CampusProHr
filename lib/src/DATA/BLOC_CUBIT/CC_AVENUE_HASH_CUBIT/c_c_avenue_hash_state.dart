part of 'c_c_avenue_hash_cubit.dart';

abstract class CCAvenueHashState extends Equatable {
  const CCAvenueHashState();
}

class CCAvenueHashInitial extends CCAvenueHashState {
  @override
  List<Object> get props => [];
}

class CCAvenueHashLoadInProgress extends CCAvenueHashState {
  @override
  List<Object> get props => [];
}

class CCAvenueHashLoadSuccess extends CCAvenueHashState {
  final List<CCAvenueHashModel> ccAvenueData;

  CCAvenueHashLoadSuccess(this.ccAvenueData);
  @override
  List<Object> get props => [ccAvenueData];
}

class CCAvenueHashLoadFail extends CCAvenueHashState {
  final String failReason;

  CCAvenueHashLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
