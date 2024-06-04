import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satutujuh/features/sequence/blocs/sequence_calculator/sequence_calculator.bloc.dart';
import 'package:satutujuh/features/sequence/blocs/sequence_calculator/sequence_calculator.state.dart';
import 'package:satutujuh/features/sequence/cubits/sequence_screen/sequence_calculator.uicubit.dart';
import 'package:satutujuh/features/sequence/cubits/sequence_screen/sequence_calculator.uistate.dart';

class ResultSection extends StatelessWidget {
  const ResultSection({super.key});

  @override
  Widget build(_) => BlocSelector<SequenceCalculatorUICubit,
          SequenceCalculatorUIState, ScrollController?>(
        selector: (state) => state.scrollController,
        builder: (_, sc) => BlocSelector<SequenceCalculatorBloc,
            SequenceCalculatorState, List<String>>(
          selector: (state) => state.sequence,
          builder: (ctx, sequence) => Scrollbar(
            controller: sc,
            thumbVisibility: true,
            trackVisibility: true,
            interactive: true,
            thickness: 10,
            child: SingleChildScrollView(
              child: Wrap(children: [
                for (final String item in sequence)
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(ctx).colorScheme.primary,
                      ),
                    ),
                  ),
              ]),
            ),
          ),
        ),
      );
}