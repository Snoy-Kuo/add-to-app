import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/widgets/news_ticker/model/model.dart';
import 'package:flutter_module/widgets/stock_ticker/model/quot_item.dart';
import 'package:meta/meta.dart';

part 'channel_state.dart';

class ChannelCubit extends Cubit<ChannelState> {
  ChannelCubit() : super(ChannelInitial());
}
