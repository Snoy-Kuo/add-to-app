import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/bloc/home_page/home_page_bloc.dart';

class MethodChannelHandler {
  //Methods
  static const String HOST_OPEN_URL = 'HOST_OPEN_URL';

  final HomePageBloc bloc;
  late MethodChannel _channel;

  MethodChannelHandler(this.bloc) {
    _initMethodChannel();
  }

  void _initMethodChannel() {
    _channel = MethodChannel('flutter_home_page');
    _channel.setMethodCallHandler((MethodCall call) async {
      //TODO: pass method and args from Host App to Client bloc
      // if (call.method == "SOME_METHOD") {
      //   bloc.add(SomeEvent(call.arguments as SomeType));
      // }
    });
  }

  @optionalTypeArgs
  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) {
    return _channel.invokeMethod(method, arguments);
  }
}
