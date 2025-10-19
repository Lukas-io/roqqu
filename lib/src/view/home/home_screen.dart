import 'package:flutter/material.dart';

import 'home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFC0CFFE), Color(0xFFF3DFF4), Color(0xFFF9D8E5)],
              stops: [0.0, 0.56, 0.96],
            ),
          ),
          child: SafeArea(child: Column(children: [HomeHeader(), Container()])),
        ),
      ),
    );
  }
}
