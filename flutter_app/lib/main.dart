import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/flutter_module.dart';

import 'app.dart';

void main() => runApp(
      MultiBlocProvider(providers: [
        BlocProvider<ChannelCubit>(
          create: (context) => ChannelCubit(),
        ),
        BlocProvider<AppBloc>(
          create: (context) => AppBloc(),
        )
      ], child: const MyApp()),
    );
