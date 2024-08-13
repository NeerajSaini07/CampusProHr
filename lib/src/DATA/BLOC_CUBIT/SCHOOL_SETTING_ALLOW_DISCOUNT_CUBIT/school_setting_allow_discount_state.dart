part of 'school_setting_allow_discount_cubit.dart';

abstract class SchoolSettingAllowDiscountState extends Equatable {
  const SchoolSettingAllowDiscountState();
}

class SchoolSettingAllowDiscountInitial
    extends SchoolSettingAllowDiscountState {
  @override
  List<Object> get props => [];
}

class SchoolSettingAllowDiscountLoadInProgress
    extends SchoolSettingAllowDiscountState {
  @override
  List<Object> get props => [];
}

class SchoolSettingAllowDiscountLoadSuccess
    extends SchoolSettingAllowDiscountState {
      final String propValue;

  SchoolSettingAllowDiscountLoadSuccess(this.propValue);
  @override
  List<Object> get props => [propValue];
}

class SchoolSettingAllowDiscountLoadFail
    extends SchoolSettingAllowDiscountState {
      final String failReason;

  SchoolSettingAllowDiscountLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
