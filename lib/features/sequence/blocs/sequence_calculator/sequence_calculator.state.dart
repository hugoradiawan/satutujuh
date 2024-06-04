import 'package:equatable/equatable.dart';

class SequenceCalculatorState extends Equatable {
  const SequenceCalculatorState({
    this.value,
    this.sequence = const <String>[],
    this.isInputValid = true,
    this.isCalculationSelected = false,
  });

  final String? value;
  final bool isInputValid, isCalculationSelected;
  final List<String> sequence;

  SequenceCalculatorState copyWith({
    String? value,
    List<String>? sequence,
    bool? isInputValid,
    bool? isCalculationSelected,
  }) =>
      SequenceCalculatorState(
        value: value ?? this.value,
        sequence: sequence ?? this.sequence,
        isInputValid: isInputValid ?? this.isInputValid,
        isCalculationSelected: isCalculationSelected ?? this.isCalculationSelected,
      );

  @override
  List<Object?> get props => [
        value,
        isInputValid,
        isCalculationSelected,
        sequence,
      ];
}
