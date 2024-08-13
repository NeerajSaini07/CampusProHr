part of 'delete_classroom_cubit.dart';

abstract class DeleteClassroomState extends Equatable {
  const DeleteClassroomState();
}

class DeleteClassroomInitial extends DeleteClassroomState {
  @override
  List<Object> get props => [];
}

class DeleteClassroomLoadInProgress extends DeleteClassroomState {
  @override
  List<Object> get props => [];
}

class DeleteClassroomLoadSuccess extends DeleteClassroomState {
  final bool status;

  DeleteClassroomLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class DeleteClassroomLoadFail extends DeleteClassroomState {
  final String failReason;

  DeleteClassroomLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
