import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/constants/AppColors.dart';
import '../../components/constants/AppFonts.dart';
import '../../components/constants/TextStyles.dart';
import '../../components/constants/constants.dart';
import '../../components/coreComponents/AppButton.dart';
import '../../viewController/controller_bloc.dart';

class KeyboardView extends StatefulWidget {
  const KeyboardView({super.key});

  @override
  State<KeyboardView> createState() => _KeyboardViewState();
}

class _KeyboardViewState extends State<KeyboardView> {
  late ControllerBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ControllerBloc>();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 10,
          children: keyboardKeys.map((letter) => buildLetterButton(letter))
              .toList(),
        ),
      ],
    );
  }

  Widget buildLetterButton(String letter) {
    return SizedBox(
      width: 45,
      child: BlocBuilder<ControllerBloc, ControllerState>(
        builder: (context, state) {
          return AppButton(
            onTap: bloc.isKeyLetterPress(letter) ? null : () =>
                bloc.add(KeyboardKeyEvent(key: letter)),
            label: letter,
            labelStyle: TextStyles.medium16White,
            fillWidth: false,
            buttonColor: bloc.isKeyLetterPress(letter)
                ? AppColors.grey50
                : null,
            padding: const EdgeInsets.all(AppFonts.s12),
          );
        },
      ),
    );
  }
}
