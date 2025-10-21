import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/controller/user_controller.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/model/copy_trader.dart';
import 'package:roqqu/src/view/home/home_screen.dart';

import '../../core/constants.dart';
import '../../core/theme/color.dart';
import '../widgets/roqqu_button.dart';

class CopySuccessScreen extends StatelessWidget {
  final CopyTrader trader;

  const CopySuccessScreen({super.key, required this.trader});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            Spacer(flex: 3),
            Image.asset(RoqquAssets.copySuccessImage, height: 80, width: 100),
            SizedBox(height: 32),

            Text(
              'Trade copied successfully',
              style: GoogleFonts.encodeSans(
                fontSize: 16,
                color: RoqquColors.text,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4),
            SizedBox(
              width: 220,

              child: Text(
                'You have successfully copied ${trader.name}’s trade.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: RoqquColors.textSecondary,
                ),
              ),
            ),
            Spacer(flex: 2),
            Container(
              decoration: BoxDecoration(
                color: RoqquColors.card,
                border: Border.all(color: RoqquColors.border, width: 1.2),
              ),
              padding: EdgeInsetsGeometry.all(16.0),
              child: RoqquButton(
                text: 'Go to dashboard',
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
