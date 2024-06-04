import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satutujuh/features/sequence/data/enums/calculation_type.enum.dart';
import 'package:satutujuh/features/sequence/blocs/sequence_calculator/sequence_calculator.bloc.dart';
import 'package:satutujuh/features/sequence/blocs/sequence_calculator/sequence_calculator.event.dart';
import 'package:satutujuh/features/sequence/blocs/sequence_calculator/sequence_calculator.state.dart';
import 'package:satutujuh/features/sequence/cubits/sequence_screen/sequence_calculator.uistate.dart';

class SequenceCalculatorUICubit extends Cubit<SequenceCalculatorUIState> {
  SequenceCalculatorUICubit({required this.calculatorBloc})
      : super(const SequenceCalculatorUIState()) {
    _subscription = calculatorBloc.stream.listen((calcState) {
      if (calcState.value == null || (state.controller?.text.isEmpty ?? true)) {
        emit(state.copyWith(value: null));
      } else if (!calcState.isInputValid) {
        emit(state.copyWith(errorInfo: 'Invalid input'));
      } else if (!calcState.isCalculationSelected) {
        emit(state.copyWith(type: null, errorInfo: 'No calculation selected'));
      } else {
        emit(state.copyWith(errorInfo: null));
      }
    });
    emit(
      state.copyWith(
        controller: TextEditingController()
          ..addListener(
            () => onTypeSelected(state.type),
          ),
      ),
    );
  }

  final SequenceCalculatorBloc calculatorBloc;
  late final StreamSubscription<SequenceCalculatorState> _subscription;

  void onTypeSelected(CalculationType? type) {
    emit(state.copyWith(type: type));
    calculatorBloc.add(OnInputValue(state.controller?.text, type));
  }

  @override
  Future<void> close() {
    state.controller?.dispose();
    _subscription.cancel();
    return super.close();
  }
}
