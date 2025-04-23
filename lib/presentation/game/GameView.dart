import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/AppExtensions.dart';

import '../../components/constants/AppFonts.dart';
import '../../components/widgets/dialog/ExitDialogView.dart';
import '../../components/widgets/dialog/GameOverDialog.dart';
import '../../viewController/controller_bloc.dart';
import '../WelcomeView.dart';
import 'GameAppBar.dart';
import 'GameInputBox.dart';
import 'GameManView.dart';
import 'KeyboardView.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {


  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ControllerBloc>();
    bloc.add(StartGameEvent());
    return BlocConsumer<ControllerBloc, ControllerState>(
      listener: (context, state) {
        if(state is GameOverState){
         gameOverCall(bloc, context);
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (value){},
          child:  const Scaffold(
            body: SafeArea(
              minimum: EdgeInsets.all(AppFonts.s16),
              child: Column(
                children: [
                  GameAppBar(),
                  Expanded(
                      flex: 9,
                      child: GameManView()),
                  GameInputBox(),
                  Expanded(
                      flex: 11,
                      child: KeyboardView()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


void gameOverCall(ControllerBloc bloc, BuildContext context ){
  context.openDialog(GameOverDialog(
    message: 'Game Over',
    onStart: ()=> {context.stopLoader,bloc.add(StartGameEvent())},
    onExit:  ()=> {context.stopLoader,context.pushAndClearNavigator(const WelcomeView())},
  ),barrierDismissible: false);
}

void exitGameCall(ControllerBloc bloc, BuildContext context ){
  context.openDialog(ExistOverDialog(
    onExit: ()=> {context.stopLoader,context.pushAndClearNavigator(const WelcomeView())},
    onStart: ()=> {context.stopLoader},
  ));
}
