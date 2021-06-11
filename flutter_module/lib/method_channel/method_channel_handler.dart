import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/bloc/bloc.dart';
import 'package:flutter_module/flutter_module.dart';

class MethodChannelHandler {
  static const String CHANNEL_NAME = 'flutter_home_page';

  //Methods
  static const String HOST_OPEN_URL = 'HOST_OPEN_URL';
  static const String HOST_OPEN_NEWS_DETAIL = 'HOST_OPEN_NEWS_DETAIL';
  static const String HOST_OPEN_NEWS_TYPE = 'HOST_OPEN_NEWS_TYPE';
  static const String HOST_OPEN_QUOT_DETAIL = 'HOST_OPEN_QUOT_DETAIL';
  static const String CLIENT_UPDATE_QUOT = 'CLIENT_UPDATE_QUOT';

  late MethodChannel _channel;
  HomePageBloc? bloc;

  MethodChannelHandler() {
    _initMethodChannel();
  }

  void _initMethodChannel() {
    _channel = MethodChannel(CHANNEL_NAME);
    _channel.setMethodCallHandler((MethodCall call) async {
      log('MethodCallHandler call=${call.method}, args=${call.arguments}');
      //TODO: pass method and args from Host App to Client bloc
      if (call.method == CLIENT_UPDATE_QUOT) {
        bloc?.add(UpdateQuot(item: QuotItem.fromJson(call.arguments)));
      }
    });
  }

  @optionalTypeArgs
  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) {
    return _channel.invokeMethod(method, arguments);
  }
}
