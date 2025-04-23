import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/constants/AppFonts.dart';
import '../../components/constants/TextStyles.dart';
import '../../components/coreComponents/TextView.dart';
import '../../viewController/controller_bloc.dart';

class GameInputBox extends StatefulWidget {
  const GameInputBox({super.key});

  @override
  State<GameInputBox> createState() => _GameInputBoxState();
}

class _GameInputBoxState extends State<GameInputBox> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ControllerBloc>();
    return BlocBuilder<ControllerBloc, ControllerState>(
      builder: (context, state) {
        return SizedBox(
          child: bloc.getInputBoxString.isEmpty
              ? const SizedBox(width: 100,)
              : FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.scaleDown,
                  child: TextView(
                    text: bloc.getInputBoxString,
                    textStyle: TextStyles.medium20WhiteSpace,
                    margin: const EdgeInsets.symmetric(vertical: AppFonts.s30),),
                ),
        );
      },
    );
  }
}
