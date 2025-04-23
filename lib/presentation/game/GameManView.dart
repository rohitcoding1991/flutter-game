import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/constants/AppFonts.dart';

import '../../components/constants/AppColors.dart';
import '../../components/constants/AppIcons.dart';
import '../../components/coreComponents/ImageView.dart';
import '../../viewController/controller_bloc.dart';

class GameManView extends StatefulWidget {
  const GameManView({super.key});

  @override
  State<GameManView> createState() => _GameManViewState();
}

class _GameManViewState extends State<GameManView> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ControllerBloc>();
    return Container(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Stack(
          children: [
            const ImageView(
              url: AppIcons.hanger,
              tintColor: AppColors.creamBrown2,
              size: 200,
            ),
            Positioned.fill(
                child: BlocBuilder<ControllerBloc, ControllerState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 114),
                        Visibility(
                          visible: bloc.manState > 0,
                          child: Container(
                            margin: const EdgeInsets.only(top: 27),
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppFonts.s40),
                                border: Border.all(
                                    color: AppColors.creamBrown2,
                                    width: 7)),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 133,
                            ),
                            Visibility(
                              visible: bloc.manState > 1,
                              child: Container(
                                height: 100,
                                width: 7,
                                color: AppColors.creamBrown2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 86.5,
                            ),
                            SizedBox(
                              height: 80,
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Visibility(
                                          visible: bloc.manState > 2,
                                          child: _arms(
                                              angle: 25 * 3.14 / 180)),
                                      Visibility(
                                          visible: bloc.manState > 4,
                                          child: _arms(
                                              angle: 155 * 3.14 / 180)),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Visibility(
                                          visible: bloc.manState > 3,
                                          child: _arms(
                                              angle: 155 * 3.14 / 180)),
                                      Visibility(
                                          visible: bloc.manState > 5,
                                          child:
                                              _arms(angle: 25 * 3.14 / 180))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  Widget _arms({required double angle}) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        height: 7,
        width: 50,
        color: AppColors.creamBrown2,
      ),
    );
  }
}
