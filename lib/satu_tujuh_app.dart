import 'package:flutter/material.dart';
import 'package:satutujuh/features/sequence/presentation/sequence_calculator.page.dart';

class SatuTujuhApp extends StatelessWidget {
  const SatuTujuhApp({super.key});

  @override
  Widget build(_) => MaterialApp(
        title: 'Sequence Calculator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: const SequenceCalculatorPage(),
      );
}