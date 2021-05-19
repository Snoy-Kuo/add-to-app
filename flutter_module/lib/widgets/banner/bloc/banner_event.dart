part of 'banner_bloc.dart';

@immutable
abstract class BannerEvent extends Equatable {}

class RefreshBanner extends BannerEvent {
  @override
  List<Object?> get props => [];
}
