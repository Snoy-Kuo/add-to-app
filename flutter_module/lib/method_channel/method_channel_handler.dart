import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/bloc/bloc.dart';
import 'package:flutter_module/flutter_module.dart';
import 'package:flutter_module/utils/log_util.dart';

class MethodChannelHandler {
  static const String CHANNEL_NAME = 'flutter_home_page';

  //Methods
  static const String HOST_OPEN_URL = 'HOST_OPEN_URL';
  static const String HOST_OPEN_NEWS_DETAIL = 'HOST_OPEN_NEWS_DETAIL';
  static const String HOST_OPEN_NEWS_TYPE = 'HOST_OPEN_NEWS_TYPE';
  static const String HOST_OPEN_QUOT_DETAIL = 'HOST_OPEN_QUOT_DETAIL';
  static const String CLIENT_UPDATE_QUOT = 'CLIENT_UPDATE_QUOT';
  static const String CLIENT_GET_LANGUAGE = 'CLIENT_GET_LANGUAGE';
  static const String CLIENT_CHANGE_LANGUAGE = 'CLIENT_CHANGE_LANGUAGE';

  late MethodChannel _channel;
  HomePageBloc? bloc;

  MethodChannelHandler() {
    _initMethodChannel();
  }

  void _initMethodChannel() {
    _channel = MethodChannel(CHANNEL_NAME);
    _channel.setMethodCallHandler((MethodCall call) async {
      LogUtil.d('call=${call.method}, args=${call.arguments}');

      // pass method and args from Host App to Client bloc
      if (call.method == CLIENT_UPDATE_QUOT) {
        bloc?.add(UpdateQuot(item: QuotItem.fromJson(call.arguments)));
      } else if (call.method == CLIENT_CHANGE_LANGUAGE) {
        LogUtil.d('bloc=$bloc');

        bloc?.add(
            ChangeLocale(locale: languageToLocale(call.arguments.toString())));
      }
    });
  }

  @optionalTypeArgs
  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) async {
    T? ret;
    try {
      ret = await _channel.invokeMethod(method, arguments);
    } catch (e) {
      LogUtil.e('e=$e');
      ret = null;
    }
    return ret;
  }
}
