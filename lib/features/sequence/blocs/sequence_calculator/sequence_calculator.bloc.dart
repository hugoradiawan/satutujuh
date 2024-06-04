import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satutujuh/features/sequence/data/enums/calculation_type.enum.dart';
import 'package:satutujuh/features/sequence/blocs/sequence_calculator/sequence_calculator.event.dart';
import 'package:satutujuh/features/sequence/blocs/sequence_calculator/sequence_calculator.state.dart';

class SequenceCalculatorBloc
    extends Bloc<SequenceCalculatorEvent, SequenceCalculatorState> {
  SequenceCalculatorBloc() : super(const SequenceCalculatorState()) {
    on<OnInputValue>(_onInputValue);
    on<NoCalculationSelected>((event, emit) {
      emit(state.copyWith(
        isCalculationSelected: false,
        sequence: const <String>[],
      ));
    });
    on<InvalidInputEvent>((event, emit) {
      emit(state.copyWith(
        value: event.value,
        isInputValid: false,
        sequence: const <String>[],
      ));
    });
  }

  void _onInputValue(
    OnInputValue event,
    Emitter<SequenceCalculatorState> emit,
  ) {
    _inputGuard(
      value: event,
      onValid: (validNumber) {
        emit(state.copyWith(
          value: event.value,
          sequence: switch (event.type) {
            (CalculationType.one) => _calculation1(validNumber),
            (CalculationType.two) => _calculation2(validNumber),
            (CalculationType.three) => _calculation3(validNumber),
            (CalculationType.four) => _calculation4(validNumber),
            _ => const <String>[],
          },
          isInputValid: true,
          isCalculationSelected: true,
        ));
      },
    );
  }

  List<String> _calculation1(int value) {
    final List<String> sequence = [];
    for (int i = 1; i <= value; i++) {
      sequence.add('$i');
    }
    return sequence;
  }

  List<String> _calculation2(int value) {
    final List<String> sequence = [];
    for (int i = 1; i <= (2 * value) - 1; i++) {
      if (i <= value) {
        sequence.add('$i');
      } else {
        sequence.add('${value - (i - value)}');
      }
    }
    return sequence;
  }

  List<String> _calculation3(int value) {
    final List<String> sequence = [];
    for (int i = 1; i <= value; i++) {
      sequence.add('${(11 * i) - 1}');
    }
    return sequence;
  }

  List<String> _calculation4(int value) {
    final List<String> sequence = [];
    for (int i = 1; i <= value; i++) {
      if (i % 5 == 0) {
        sequence.add('LIMA');
      } else if (i % 7 == 0) {
        sequence.add('TUJUH');
      } else {
        sequence.add('$i');
      }
    }
    return sequence;
  }

  void _inputGuard({
    required OnInputValue value,
    required void Function(int) onValid,
    VoidCallback? onInvalid,
  }) {
    if (value.type == null) {
      add(const NoCalculationSelected());
    }
    final int? number = int.tryParse(value.value ?? '');
    if (number == null || number < 0) {
      if (onInvalid != null) {
        onInvalid();
      } else {
        add(InvalidInputEvent(value.value));
      }
    } else {
      onValid(number);
    }
  }
}
