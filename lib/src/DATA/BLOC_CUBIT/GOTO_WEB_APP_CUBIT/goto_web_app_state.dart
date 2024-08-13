part of 'goto_web_app_cubit.dart';

abstract class GotoWebAppState extends Equatable {
  const GotoWebAppState();
}

class GotoWebAppInitial extends GotoWebAppState {
  @override
  List<Object> get props => [];
}

class GotoWebAppLoadInProgress extends GotoWebAppState {
  @override
  List<Object> get props => [];
}

class GotoWebAppLoadSuccess extends GotoWebAppState {
  final String url;
  GotoWebAppLoadSuccess(this.url);
  @override
  List<Object> get props => [url];
}

class GotoWebAppLoadFail extends GotoWebAppState {
  final String failReason;
  GotoWebAppLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
