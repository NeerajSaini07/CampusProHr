part of 'load_class_for_sms_cubit.dart';

abstract class LoadClassForSmsState extends Equatable {
  const LoadClassForSmsState();
}

class LoadClassForSmsInitial extends LoadClassForSmsState {
  @override
  List<Object> get props => [];
}

class LoadClassForSmsLoadInProgress extends LoadClassForSmsState {
  @override
  List<Object> get props => [];
}

class LoadClassForSmsLoadSuccess extends LoadClassForSmsState {
  final List<LoadClassForSmsModel> classList;
  LoadClassForSmsLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class LoadClassForSmsLoadFail extends LoadClassForSmsState {
  final String failReason;
  LoadClassForSmsLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
