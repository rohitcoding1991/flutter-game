import 'package:flutter/material.dart';
import '../components/constants/AppStrings.dart';
import '../utils/AppExtensions.dart';
import '../components/constants/AppFonts.dart';
import '../components/coreComponents/AppButton.dart';
import 'ScoreView.dart';
import 'SplashView.dart';
import 'game/GameView.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(AppFonts.s20),
        child: Column(
          children: [
            Expanded(child: Center(child: logoView())),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  onTap:()=> context.pushAndClearNavigator(const GameView()),
                  label: 'Start',margin: const EdgeInsets.only(bottom: AppFonts.s40),),
                AppButton(onTap:()=> context.pushNavigator(const ScoreView()),label: AppStrings.scores,),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
