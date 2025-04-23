import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/DateTimeUtils.dart';
import '../components/constants/AppFonts.dart';
import '../components/constants/AppStrings.dart';
import '../model/ScoreModel.dart';
import '../utils/AppExtensions.dart';

import '../components/constants/TextStyles.dart';
import '../components/coreComponents/TextView.dart';
import '../components/widgets/AppBar2.dart';
import '../viewController/controller_bloc.dart';

class ScoreView extends StatefulWidget {
  const ScoreView({super.key});

  @override
  State<ScoreView> createState() => _ScoreViewState();
}

class _ScoreViewState extends State<ScoreView> {
  late ControllerBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ControllerBloc>();
    _bloc.add(GetScoresEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar2(
              title: AppStrings.scores,
              titleStyle: TextStyles.semiBold24CreamBrown,
              onLeadTap: context.pop,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppFonts.s10),
              child: _scoreRow(data: [
                _header(AppStrings.rank),
                _header(AppStrings.date),
                _header(AppStrings.score),
              ]),
            ),
            Expanded(child: BlocBuilder<ControllerBloc, ControllerState>(
              builder: (context, state) {
                return SizedBox(
                  child: _bloc.scoresList.isEmpty ?
                      const Center(child: TextView(text: 'No scores available.',textStyle: TextStyles.semiBold16White,),)
                      : ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => _scoreCard(index, _bloc.scoresList[index]),
                      separatorBuilder: (context, index) => const SizedBox(height: AppFonts.s20,),
                      itemCount: _bloc.scoresList.length),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  Widget _value(String text) => TextView(
    text: text,
    textAlign: TextAlign.center,
    textStyle: TextStyles.medium14White,
  );

  Widget _header(String text) => TextView(
    text: text,
    textAlign: TextAlign.center,
    textStyle: TextStyles.semiBold16White,
  );

  Widget _scoreCard(int index, ScoreModel data) => _scoreRow(data: [
    _value('${index + 1}'),
    _value(data.timeStamp?.ddMMMyyyy ?? ''),
    _value('${data.score ?? ''}')
  ]);

  Widget _scoreRow({required List<Widget> data}) {
    return Row(
      children: [
        Expanded(child: data[0]),
        Expanded(child: data[1]),
        Expanded(child: data[2]),
      ],
    );
  }
}
