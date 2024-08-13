part of 'cce_attendance_class_data_cubit.dart';

abstract class CceAttendanceClassDataState extends Equatable {
  const CceAttendanceClassDataState();
}

class CceAttendanceClassDataInitial extends CceAttendanceClassDataState {
  @override
  List<Object> get props => [];
}

class CceAttendanceClassDataLoadInProgress extends CceAttendanceClassDataState {
  @override
  List<Object> get props => [];
}

class CceAttendanceClassDataLoadSuccess extends CceAttendanceClassDataState {
  final List<CceAttendanceClassDataModel> classData;
  CceAttendanceClassDataLoadSuccess(this.classData);
  @override
  List<Object> get props => [classData];
}

class CceAttendanceClassDataLoadFail extends CceAttendanceClassDataState {
  final String failReason;
  CceAttendanceClassDataLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
