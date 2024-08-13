part of 'publish_result_admin_cubit.dart';

abstract class PublishResultAdminState extends Equatable {
  const PublishResultAdminState();
}

class PublishResultAdminInitial extends PublishResultAdminState {
  @override
  List<Object> get props => [];
}

class PublishResultAdminLoadInProgress extends PublishResultAdminState {
  @override
  List<Object> get props => [];
}

class PublishResultAdminLoadSuccess extends PublishResultAdminState {
  final String result;
  PublishResultAdminLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class PublishResultAdminLoadFail extends PublishResultAdminState {
  final String failReason;
  PublishResultAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
