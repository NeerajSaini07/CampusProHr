part of 'save_class_room_cubit.dart';

abstract class SaveClassRoomState extends Equatable {
  const SaveClassRoomState();
}

class SaveClassRoomInitial extends SaveClassRoomState {
  @override
  List<Object> get props => [];
}

class SaveClassRoomLoadInProgress extends SaveClassRoomState {
  @override
  List<Object> get props => [];
}

class SaveClassRoomLoadSuccess extends SaveClassRoomState {
  final String result;
  SaveClassRoomLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class SaveClassRoomLoadFail extends SaveClassRoomState {
  final String failReason;
  SaveClassRoomLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
