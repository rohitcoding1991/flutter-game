import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/constants/AppFonts.dart';
import '../../components/constants/AppIcons.dart';
import '../../components/constants/TextStyles.dart';
import '../../components/coreComponents/ImageView.dart';
import '../../components/coreComponents/TextView.dart';
import '../../viewController/controller_bloc.dart';
import 'GameView.dart';

class GameAppBar extends StatefulWidget {
  const GameAppBar({super.key});

  @override
  State<GameAppBar> createState() => _GameAppBarState();
}

class _GameAppBarState extends State<GameAppBar> {

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ControllerBloc>();
    return BlocBuilder<ControllerBloc, ControllerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppFonts.s10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  const ImageView(url: AppIcons.fav, size: AppFonts.s30,),
                  Positioned.fill(child: Center(
                    child: TextView(
                      text: '${bloc.life}', textStyle: TextStyles.semiBold14Background,),
                  ))
                ],
              ),
              TextView(text: '${bloc.score}', textStyle: TextStyles.semiBold24CreamBrown,),
              ImageView(onTap: ()=> exitGameCall(bloc,context),
                url: AppIcons.exit, size: AppFonts.s30,),
            ],
          ),
        );
      },
    );
  }
}
