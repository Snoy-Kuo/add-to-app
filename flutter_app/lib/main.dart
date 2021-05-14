import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/bloc/bloc.dart';

import 'app.dart';

void main() => runApp(
      BlocProvider<HostCubit>(
        create: (context) {
          return HostCubit();
        },
        child: const MyApp(),
      ),
    );
