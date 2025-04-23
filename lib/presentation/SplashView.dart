import 'package:flutter/material.dart';
import '../utils/AppExtensions.dart';
import '../components/constants/AppFonts.dart';
import '../components/constants/AppIcons.dart';
import '../components/constants/AppStrings.dart';
import '../components/constants/TextStyles.dart';
import '../components/coreComponents/ImageView.dart';
import '../components/coreComponents/TextView.dart';
import 'WelcomeView.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    onCreate();
    super.initState();
  }

  void onCreate()async{
    Future.delayed(const Duration(seconds: 3),() {
      context.pushAndClearNavigator(const WelcomeView());
    },);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logoView(),
          const TextView(text: AppStrings.appNLineName,
            textAlign: TextAlign.center,
            textStyle: TextStyles.semiBold24CreamBrown,
            margin: EdgeInsets.only(top: AppFonts.s16),
          ),
        ],
      )),
    );
  }
}

Widget logoView(){
  return const ImageView(url: AppIcons.hangman, size: 150,);
}
