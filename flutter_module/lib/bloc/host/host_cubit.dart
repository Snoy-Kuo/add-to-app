import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_module/widgets/news_ticker/model/model.dart';
import 'package:meta/meta.dart';

part 'host_state.dart';

class HostCubit extends Cubit<HostState> {
  HostCubit() : super(HostInitial());
}
