
part of 'host_cubit.dart';

@immutable
abstract class HostState  extends Equatable{}

class HostInitial extends HostState {
  @override
  List<Object?> get props => [];
}

class HostOpenUrl extends HostState {
  final String url;

  HostOpenUrl({required this.url});

  @override
  List<Object?> get props => [url];
}
