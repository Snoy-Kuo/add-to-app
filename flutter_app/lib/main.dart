import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/flutter_module.dart';

import 'app.dart';
import 'bloc/app_bloc.dart';
import 'model/mock_realtime_quot_repo.dart';

void main() => runApp(
      BlocProvider<ChannelCubit>(
        create: (context) => ChannelCubit(),
        child: BlocProvider<AppBloc>(
          create: (context) {
            ChannelCubit chCubit = BlocProvider.of<ChannelCubit>(context);
            return AppBloc(rtRepo: MockRealtimeQuotRepo(), chCubit: chCubit);
          },
          child: const MyApp(),
        ),
      ),
    );
