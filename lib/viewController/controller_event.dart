part of 'controller_bloc.dart';

abstract class ControllerEvent extends Equatable {
  const ControllerEvent();
}

class StartGameEvent extends ControllerEvent{
  @override
  List<Object?> get props => [];
}

class HangmanNextEvent extends ControllerEvent{
  @override
  List<Object?> get props => [];
}

class NextLifeEvent extends ControllerEvent{
  @override
  List<Object?> get props => [];
}

class GameOverEvent extends ControllerEvent{
  @override
  List<Object?> get props => [];
}

class KeyboardKeyEvent extends ControllerEvent{
  final String key;

  const KeyboardKeyEvent({required this.key});

  @override
  List<Object?> get props => [key];
}

class GetScoresEvent extends ControllerEvent{
  @override
  List<Object?> get props => [];
}




