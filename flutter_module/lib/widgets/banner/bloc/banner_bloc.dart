import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_module/utils/log_util.dart';
import 'package:flutter_module/widgets/banner/model/banner_item.dart';
import 'package:flutter_module/widgets/banner/model/banner_repo.dart';
import 'package:meta/meta.dart';

part 'banner_event.dart';

part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRepo repository;
  List<BannerItem>? list = [];

  BannerBloc({required this.repository}) : super(BannerLoading());

  @override
  Stream<BannerState> mapEventToState(
    BannerEvent event,
  ) async* {
    if (event is RefreshBanner) {
      yield* _mapRefreshBannerToState();
    }
  }

  Stream<BannerState> _mapRefreshBannerToState() async* {
    try {
      yield BannerLoading();
      list = await repository.fetchBannerList();
      yield BannerLoaded(list ?? []);
    } catch (e) {
      LogUtil.e('e=$e');
      yield BannerError(code: '-1', msg: 'Something wrong');
    }
  }
}
