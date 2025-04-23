part of 'controller_bloc.dart';

abstract class ControllerState extends Equatable {
  const ControllerState();
}

class ControllerInitial extends ControllerState {
  @override
  List<Object> get props => [];
}

class ControllerReset extends ControllerState {
  @override
  List<Object> get props => [];
}

class GameOverState extends ControllerState {
  @override
  List<Object> get props => [];
}
