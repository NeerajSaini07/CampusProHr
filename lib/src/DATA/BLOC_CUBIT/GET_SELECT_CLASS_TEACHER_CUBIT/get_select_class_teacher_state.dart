part of 'get_select_class_teacher_cubit.dart';

abstract class GetSelectClassTeacherState extends Equatable {
  const GetSelectClassTeacherState();
}

class GetSelectClassTeacherInitial extends GetSelectClassTeacherState {
  @override
  List<Object> get props => [];
}

class GetSelectClassTeacherLoadInProgress extends GetSelectClassTeacherState {
  @override
  List<Object> get props => [];
}

class GetSelectClassTeacherLoadSuccess extends GetSelectClassTeacherState {
  final List selectedClass;
  GetSelectClassTeacherLoadSuccess(this.selectedClass);
  @override
  List<Object> get props => [selectedClass];
}

class GetSelectClassTeacherLoadFail extends GetSelectClassTeacherState {
  final String failReason;
  GetSelectClassTeacherLoadFail(this.failReason);

  @override
  List<Object> get props => [failReason];
}
