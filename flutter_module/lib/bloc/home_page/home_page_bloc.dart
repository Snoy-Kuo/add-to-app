import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_module/bloc/host/host_cubit.dart';
import 'package:meta/meta.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HostCubit? hostCubit;

  // ignore: cancel_subscriptions
  StreamSubscription? hostSub;

  HomePageBloc(this.hostCubit) : super(HomePageInitial()) {
    if (hostCubit == null) {
      return;
    }
    hostSub = hostCubit!.stream.listen((state) {
      //Todo: listen to host state, and add hp event
    });
  }

  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }

  @override
  Future<void> close() {
    if (hostSub != null) {
      hostSub!.cancel();
    }

    return super.close();
  }
}
