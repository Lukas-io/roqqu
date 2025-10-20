import 'package:flutter/material.dart';
import 'package:roqqu/src/view/dashboard/dashboard_content.dart';
import '../../core/constants.dart';
import '../../core/theme/color.dart';
import 'dashboard_header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My dashboard",
          style: TextStyle(color: RoqquColors.text, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: RoqquConstants.horizontalPadding,
          vertical: 16,
        ),
        child: SafeArea(
          child: Column(
            spacing: 12,
            children: [DashboardHeader(), DashboardContent()],
          ),
        ),
      ),
    );
  }
}
