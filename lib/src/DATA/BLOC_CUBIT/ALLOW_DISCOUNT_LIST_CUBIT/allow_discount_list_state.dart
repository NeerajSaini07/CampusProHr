part of 'allow_discount_list_cubit.dart';

abstract class AllowDiscountListState extends Equatable {
  const AllowDiscountListState();
}

class AllowDiscountListInitial extends AllowDiscountListState {
  @override
  List<Object> get props => [];
}

class AllowDiscountListLoadInProgress extends AllowDiscountListState {
  @override
  List<Object> get props => [];
}

class AllowDiscountListLoadSuccess extends AllowDiscountListState {
  final List<AllowDiscountListModel> allowDiscountList;

  AllowDiscountListLoadSuccess(this.allowDiscountList);
  @override
  List<Object> get props => [allowDiscountList];
}

class AllowDiscountListLoadFail extends AllowDiscountListState {
  final String failReason;

  AllowDiscountListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
