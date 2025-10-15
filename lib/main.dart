import 'package:flutter/material.dart';
import 'package:roqqu/src/core/theme/theme.dart';
import 'package:roqqu/src/view/splash_screen.dart';

void main() {
  runApp(const Roqqu());
}

class Roqqu extends StatelessWidget {
  const Roqqu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roqqu',
      theme: RoqquTheme.appTheme,
      home: const SplashScreen(),
    );
  }
}
