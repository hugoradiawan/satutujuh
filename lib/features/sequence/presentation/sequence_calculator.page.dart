import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satutujuh/features/sequence/data/enums/calculation_type.enum.dart';
import 'package:satutujuh/features/sequence/presentation/components/result_section.component.dart';
import 'package:satutujuh/features/sequence/blocs/sequence_calculator/sequence_calculator.bloc.dart';
import 'package:satutujuh/features/sequence/cubits/sequence_screen/sequence_calculator.uicubit.dart';
import 'package:satutujuh/features/sequence/cubits/sequence_screen/sequence_calculator.uistate.dart';

class SequenceCalculatorPage extends StatelessWidget {
  const SequenceCalculatorPage({super.key});

  @override
  Widget build(_) => SafeArea(
        child: Scaffold(
          body: Center(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => SequenceCalculatorBloc()),
                BlocProvider(
                  create: (ctx) => SequenceCalculatorUICubit(
                    calculatorBloc: ctx.read<SequenceCalculatorBloc>(),
                  ),
                ),
              ],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BlocBuilder<SequenceCalculatorUICubit,
                      SequenceCalculatorUIState>(
                    buildWhen: (pre, curr) => pre.controller != curr.controller,
                    builder: (ctx, state) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        key: const Key('input_text_field'),
                        cursorColor: Theme.of(ctx).colorScheme.surface,
                        style: const TextStyle(color: Colors.white),
                        controller: state.controller,
                        decoration: InputDecoration(
                          fillColor: Theme.of(ctx).primaryColor,
                          filled: true,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  BlocSelector<SequenceCalculatorUICubit,
                      SequenceCalculatorUIState, CalculationType?>(
                    selector: (state) => state.type,
                    builder: (ctx, selected) => Wrap(children: [
                      for (final type in CalculationType.values)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            key: Key('calculation_type_${type.value}'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selected == type
                                  ? Theme.of(ctx).colorScheme.primary
                                  : Theme.of(ctx).colorScheme.secondary,
                              minimumSize: const Size(140, 50),
                            ),
                            onPressed: () {
                              ctx
                                  .read<SequenceCalculatorUICubit>()
                                  .onTypeSelected(
                                    type,
                                  );
                            },
                            child: Text(
                              '${type.value}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ]),
                  ),
                  BlocSelector<SequenceCalculatorUICubit,
                      SequenceCalculatorUIState, String?>(
                    selector: (state) => state.errorInfo,
                    builder: (_, errorInfo) => errorInfo != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              errorInfo,
                              style: const TextStyle(color: Colors.red),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Result:',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const Expanded(child: ResultSection()),
                ],
              ),
            ),
          ),
        ),
      );
}
