import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/storage/StorageService.dart';
import 'package:provider/single_child_widget.dart';

import 'components/constants/AppTheme.dart';
import 'presentation/SplashView.dart';
import 'viewController/controller_bloc.dart';



void main() async{
  await StorageService.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child:  MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => ControllerBloc(),
          child: const SplashView(),
        ),
      ),
    );
  }
}

List<SingleChildWidget> providers = [
  BlocProvider(create: (context) => ControllerBloc()),
];

