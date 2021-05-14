part of 'banner_bloc.dart';

@immutable
abstract class BannerState extends Equatable {}

class BannerLoading extends BannerState {
  @override
  List<Object?> get props => [];
}

class BannerLoaded extends BannerState {
  final List<BannerItem> list;

  BannerLoaded([this.list = const []]);

  @override
  List<Object?> get props => [list];
}

class BannerError extends BannerState {
  final String msg;
  final String code;

  BannerError({required this.code, required this.msg});

  @override
  List<Object?> get props => [msg, code];
}
