import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:satutujuh/features/sequence/data/enums/calculation_type.enum.dart';

class SequenceCalculatorUIState extends Equatable {
  const SequenceCalculatorUIState({
    this.value,
    this.type,
    this.errorInfo,
    this.controller,
    this.scrollController,
  });

  final int? value;
  final CalculationType? type;
  final bool? isInputValid = true;
  final String? errorInfo;

  final TextEditingController? controller;
  final ScrollController? scrollController;

  SequenceCalculatorUIState copyWith({
    int? value,
    CalculationType? type,
    String? errorInfo,
    TextEditingController? controller,
    ScrollController? scrollController,
  }) =>
      SequenceCalculatorUIState(
        value: value ?? this.value,
        type: type ?? this.type,
        errorInfo: errorInfo,
        controller: controller ?? this.controller,
        scrollController: scrollController ?? this.scrollController,
      );

  @override
  List<Object?> get props => [
        value,
        type,
        isInputValid,
        errorInfo,
        controller,
        scrollController,
      ];
}
