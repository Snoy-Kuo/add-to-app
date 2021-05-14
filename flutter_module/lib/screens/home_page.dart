import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/bloc/bloc.dart';
import 'package:flutter_module/method_channel/method_channel_handler.dart';
import 'package:flutter_module/widgets/banner/banner.dart';

class MyHomePage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  final String? title;

  const MyHomePage([this.title]);

  @override
  Widget build(BuildContext context) {
    //make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    MethodChannelHandler? _channelHandler;

    return BlocProvider<HomePageBloc>(
      create: (_) {
        HostCubit? hostCubit;
        try {
          hostCubit = BlocProvider.of<HostCubit>(context);
        } catch (e) {
          hostCubit = null;
        }
        final bloc =
            HomePageBloc(hostCubit); //context.read<HomePageHostBloc>());
        _channelHandler = MethodChannelHandler(bloc);
        return bloc;
      },
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          //TODO: build by state
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              BannerView(
                repository: MockBannerRepo(),
                onItemClick: (item) => onBannerItemClick(item, _channelHandler),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    title ?? 'This is Home Widget\n from module',
                    style: optionStyle,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void onBannerItemClick(
      BannerItem? item, MethodChannelHandler? channelHandler) {
    String url = item?.targetUrl ?? '';
    log('onBannerItemClick item=${item?.id ?? null}, url=$url');
    channelHandler?.invokeMethod(MethodChannelHandler.HOST_OPEN_URL, url);
    channelHandler?.bloc.hostCubit?.emit(HostOpenUrl(url: url));
  }
}
