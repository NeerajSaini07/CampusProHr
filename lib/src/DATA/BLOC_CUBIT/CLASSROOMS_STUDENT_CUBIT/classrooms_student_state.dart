part of 'classrooms_student_cubit.dart';

abstract class ClassRoomsStudentState extends Equatable {
  const ClassRoomsStudentState();
}

class ClassRoomsStudentInitial extends ClassRoomsStudentState {
  @override
  List<Object> get props => [];
}

class ClassRoomsStudentLoadInProgress extends ClassRoomsStudentState {
  @override
  List<Object> get props => [];
}

class ClassRoomsStudentLoadSuccess extends ClassRoomsStudentState {
  final List<ClassRoomsStudentModel> classRoomsList;

  ClassRoomsStudentLoadSuccess(this.classRoomsList);
  @override
  List<Object> get props => [classRoomsList];
}

class ClassRoomsStudentLoadFail extends ClassRoomsStudentState {
  final String failReason;

  ClassRoomsStudentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
