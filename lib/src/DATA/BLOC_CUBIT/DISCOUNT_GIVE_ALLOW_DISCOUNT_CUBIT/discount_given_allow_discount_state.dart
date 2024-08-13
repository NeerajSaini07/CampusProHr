part of 'discount_given_allow_discount_cubit.dart';

abstract class DiscountGivenAllowDiscountState extends Equatable {
  const DiscountGivenAllowDiscountState();
}

class DiscountGivenAllowDiscountInitial
    extends DiscountGivenAllowDiscountState {
  @override
  List<Object> get props => [];
}

class DiscountGivenAllowDiscountLoadInProgress
    extends DiscountGivenAllowDiscountState {
  @override
  List<Object> get props => [];
}

class DiscountGivenAllowDiscountLoadSuccess
    extends DiscountGivenAllowDiscountState {
      final List<DiscountGivenAllowDiscountModel> discountGivenAllowDiscount;

  DiscountGivenAllowDiscountLoadSuccess(this.discountGivenAllowDiscount);
  @override
  List<Object> get props => [discountGivenAllowDiscount];
}

class DiscountGivenAllowDiscountLoadFail
    extends DiscountGivenAllowDiscountState {
      final String failReason;

  DiscountGivenAllowDiscountLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
