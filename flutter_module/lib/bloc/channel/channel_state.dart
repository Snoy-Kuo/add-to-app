part of 'channel_cubit.dart';

@immutable
abstract class ChannelState extends Equatable {}

class ChannelInitial extends ChannelState {
  @override
  List<Object?> get props => [];
}

class HostOpenUrl extends ChannelState {
  final int _time = DateTime.now().millisecondsSinceEpoch;
  final String url;

  HostOpenUrl({required this.url});

  @override
  List<Object?> get props => [url, _time];
}

class HostOpenNewsDetail extends ChannelState {
  final int _time = DateTime.now().millisecondsSinceEpoch;
  final NewsItem item;

  HostOpenNewsDetail({required this.item});

  @override
  List<Object?> get props => [item, _time];
}

class HostOpenNewsType extends ChannelState {
  final int _time = DateTime.now().millisecondsSinceEpoch;
  final NewsType type;

  HostOpenNewsType({required this.type});

  @override
  List<Object?> get props => [type, _time];
}

class ClientGetTheme extends ChannelState {
  final int _time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [_time];
}

class ClientChangeTheme extends ChannelState {
  final ThemeMode mode;

  ClientChangeTheme({required this.mode});

  @override
  List<Object?> get props => [mode];
}

class ClientGetLanguage extends ChannelState {
  final int _time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [_time];
}

class ClientChangeLanguage extends ChannelState {
  final int _time = DateTime.now().millisecondsSinceEpoch;
  final String language;

  ClientChangeLanguage({required this.language});

  @override
  List<Object?> get props => [language, _time];
}

class HostOpenQuotDetail extends ChannelState {
  final int _time = DateTime.now().millisecondsSinceEpoch;
  final QuotItem item;

  HostOpenQuotDetail({required this.item});

  @override
  List<Object?> get props => [item, _time];
}

class ClientUpdateQuot extends ChannelState {
  final QuotItem item;

  ClientUpdateQuot({required this.item});

  @override
  List<Object?> get props => [item];
}

class ClientChangeUserLv extends ChannelState {
  final bool isRookie;

  ClientChangeUserLv({required this.isRookie});

  @override
  List<Object?> get props => [isRookie];
}
