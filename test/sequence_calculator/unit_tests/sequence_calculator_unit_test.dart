import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satutujuh/features/sequence/blocs/sequence_calculator/sequence_calculator.bloc.dart';
import 'package:satutujuh/features/sequence/blocs/sequence_calculator/sequence_calculator.event.dart';
import 'package:satutujuh/features/sequence/blocs/sequence_calculator/sequence_calculator.state.dart';
import 'package:satutujuh/features/sequence/data/enums/calculation_type.enum.dart';

class MockSequenceCalculatorBloc
    extends MockBloc<SequenceCalculatorEvent, SequenceCalculatorState>
    implements SequenceCalculatorBloc {}

class TestData {
  final String description, inputValue;
  final CalculationType calculationType;
  final List<String> expectedSequence;

  const TestData({
    required this.description,
    required this.inputValue,
    required this.calculationType,
    required this.expectedSequence,
  });
}

void main() {
  group('Test All Calculations:', () {
    final List<TestData> testData = [
      const TestData(
        description: 'Calculation 1',
        inputValue: '9',
        calculationType: CalculationType.one,
        expectedSequence: <String>[
          '1',
          '2',
          '3',
          '4',
          '5',
          '6',
          '7',
          '8',
          '9',
        ],
      ),
      const TestData(
        description: 'Calculation 2',
        inputValue: '5',
        calculationType: CalculationType.two,
        expectedSequence: <String>[
          '1',
          '2',
          '3',
          '4',
          '5',
          '4',
          '3',
          '2',
          '1',
        ],
      ),
      const TestData(
        description: 'Calculation 3',
        inputValue: '5',
        calculationType: CalculationType.three,
        expectedSequence: <String>[
          '10',
          '21',
          '32',
          '43',
          '54',
        ],
      ),
      const TestData(
        description: 'Calculation 4',
        inputValue: '9',
        calculationType: CalculationType.four,
        expectedSequence: <String>[
          '1',
          '2',
          '3',
          '4',
          'LIMA',
          '6',
          'TUJUH',
          '8',
          '9',
        ],
      ),
    ];

    for (final data in testData) {
      blocTest<SequenceCalculatorBloc, SequenceCalculatorState>(
        data.description,
        build: () => SequenceCalculatorBloc(),
        act: (bloc) =>
            bloc.add(OnInputValue(data.inputValue, data.calculationType)),
        expect: () => <SequenceCalculatorState>[
          SequenceCalculatorState(
            value: data.inputValue,
            sequence: data.expectedSequence,
            isInputValid: true,
            isCalculationSelected: true,
          ),
        ],
      );
    }
  });
}
