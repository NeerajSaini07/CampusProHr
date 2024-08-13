part of 'save_employee_image_cubit.dart';

abstract class SaveEmployeeImageState extends Equatable {
  const SaveEmployeeImageState();
}

class SaveEmployeeImageInitial extends SaveEmployeeImageState {
  @override
  List<Object> get props => [];
}

class SaveEmployeeImageLoadInProgress extends SaveEmployeeImageState {
  @override
  List<Object> get props => [];
}

class SaveEmployeeImageLoadSuccess extends SaveEmployeeImageState {
  final bool status;

  SaveEmployeeImageLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SaveEmployeeImageLoadFail extends SaveEmployeeImageState {
  final String failReason;

  SaveEmployeeImageLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
