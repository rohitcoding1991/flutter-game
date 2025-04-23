import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../components/constants/constants.dart';
import '../model/ScoreModel.dart';
import '../services/repo/ScoreRepo.dart';
import '../utils/AppExtensions.dart';
import '../utils/DateTimeUtils.dart';

part 'controller_event.dart';

part 'controller_state.dart';

final Random random = Random();

class ControllerBloc extends Bloc<ControllerEvent, ControllerState> {
  final _repo = ScoreRepoImplementation();

  int life = 5;
  int score = 0;
  int manState = 0;
  String _word = '';

  List<String> _selectedKeyBoardKeys = [];
  final List<String> _libraryList = [];
  List<String> _wordList = [];
  List<ScoreModel> scoresList = [];

  ControllerBloc() : super(ControllerInitial()) {
    on<StartGameEvent>(_onStartGame);
    on<HangmanNextEvent>(_onHangmanNext);
    on<NextLifeEvent>(_onNextLife);
    on<KeyboardKeyEvent>(_onKeyPress);
    on<GameOverEvent>(_onGameOver);
    on<GetScoresEvent>(_onGetScores);
  }

  FutureOr<void> _onStartGame(
      StartGameEvent event, Emitter<ControllerState> emit) {
    _resetValuesToStart();
    _changeState(emit);
    _startManHangTimer(emit);
  }

  FutureOr<void> _onHangmanNext(
      HangmanNextEvent event, Emitter<ControllerState> emit) {
    _changeState(emit);
  }

  FutureOr<void> _onKeyPress(
      KeyboardKeyEvent event, Emitter<ControllerState> emit) {
    _selectedKeyBoardKeys.add(event.key);
    List<String> list = _word.split('');

    _wordList = list
        .asMap()
        .map((index, char) => MapEntry(
            index,
            char.toLowerCase() == event.key.toLowerCase()
                ? event.key
                : _wordList[index]))
        .values
        .toList();

    if (getInputBoxString.toLowerCase().isEquals(_word.toLowerCase())) {
      score++;
      _changeQuestion();
      _changeState(emit);
      _startManHangTimer(emit);
    } else {
      _changeState(emit);
    }
  }

  FutureOr<void> _onNextLife(
      NextLifeEvent event, Emitter<ControllerState> emit) {
    _changeQuestion();
    _changeState(emit);
    _startManHangTimer(emit);
  }

  FutureOr<void> _onGameOver(
      GameOverEvent event, Emitter<ControllerState> emit) {
    emit(GameOverState());
  }

  Timer? _timer;

  bool isKeyLetterPress(String value) =>
      _selectedKeyBoardKeys.indexWhere((element) => element == value) > -1;

  String get getInputBoxString =>
      _wordList.map((item) => item.trim().isEmpty ? '_' : item).join('');

  void _changeState(Emitter<ControllerState> emit) async {
    if (state is ControllerInitial) {
      emit(ControllerReset());
    } else {
      emit(ControllerInitial());
    }
  }

  void _startManHangTimer(Emitter<ControllerState> emit) {
    _timer?.cancel();
    int count = 0;
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      count++;
      if (count <= 6) {
        manState = count;
        add(HangmanNextEvent());
      }
      if (count > 6) {
        _timer?.cancel();
        manState = 0;
        if (life > 0) {
          life--;
          add(NextLifeEvent());
        } else {
          _addScore();
          add(GameOverEvent());
        }
      }
    });
  }

  void _resetValuesToStart() {
    _libraryList.clear();
    _libraryList.addAll(wordLibrary);
    life = 5;
    score = 0;
    manState = 0;
    _changeQuestion();
  }

  void _changeQuestion() {
    manState = 0;
    _word = _libraryList[_getRandomNumber(_libraryList.length)];
    _libraryList.remove(_word);
    _selectedKeyBoardKeys = [];
    _wordList = List.generate(_word.length, (index) => '');
  }

  void _addScore() => {_repo.addScore(score: ScoreModel(score: score, timeStamp: DateTimeUtils.getCurrentTimeStamp)),_repo.getScores()};

  FutureOr<void> _onGetScores(GetScoresEvent event, Emitter<ControllerState> emit) async{
    _changeState(emit);
    scoresList.clear();
    scoresList.addAll(await _repo.getScores());
    _changeState(emit);
  }
}

int _getRandomNumber(int count) => random.nextInt(count);
