part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState extends Equatable{}

class HomePageInitial extends HomePageState {
  @override
  List<Object?> get props => [];
}

class HomePageUpdated extends HomePageState {

  HomePageUpdated();

  @override
  List<Object?> get props => [];
}
