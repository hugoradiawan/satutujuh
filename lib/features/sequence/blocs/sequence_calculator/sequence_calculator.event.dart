import 'package:satutujuh/features/sequence/data/enums/calculation_type.enum.dart';

abstract class SequenceCalculatorEvent {
  const SequenceCalculatorEvent({this.value});
  final String? value;
}

class OnInputValue extends SequenceCalculatorEvent {
  const OnInputValue(String? value, this.type) : super(value: value);

  final CalculationType? type;
}

class InvalidInputEvent extends SequenceCalculatorEvent {
  const InvalidInputEvent(String? value) : super(value: value);
}

class NoCalculationSelected extends SequenceCalculatorEvent {
  const NoCalculationSelected();
}
