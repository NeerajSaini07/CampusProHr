part of 'drawer_cubit.dart';

abstract class DrawerState extends Equatable {
  const DrawerState();
}

class DrawerInitial extends DrawerState {
  @override
  List<Object> get props => [];
}

class DrawerLoadInProgress extends DrawerState {
  @override
  List<Object> get props => [];
}

class DrawerLoadSuccess extends DrawerState {
  final List<DrawerModel> drawerItems;

  DrawerLoadSuccess(this.drawerItems);
  @override
  List<Object> get props => [drawerItems];
}

class DrawerLoadFail extends DrawerState {
  final String failReason;

  DrawerLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
