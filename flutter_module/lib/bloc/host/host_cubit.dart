import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'host_state.dart';

class HostCubit extends Cubit<HostState> {
  HostCubit() : super(HostInitial());
}
