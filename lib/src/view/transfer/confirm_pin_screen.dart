import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/controller/user_controller.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/model/copy_trader.dart';
import 'package:roqqu/src/view/transfer/copy_success_screen.dart';

import '../../core/constants.dart';
import '../../core/theme/color.dart';
import '../trader/keypad_widget.dart';

class ConfirmPinScreen extends StatelessWidget {
  final CopyTrader trader;
  final double amount;

  const ConfirmPinScreen({
    super.key,
    required this.trader,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Image.asset(RoqquAssets.pinLockImage, width: 32, height: 32),
                  SizedBox(height: 28),
                  Text(
                    'Confirm Transaction',
                    style: GoogleFonts.encodeSans(
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      color: RoqquColors.text,
                    ),
                  ),
                  SizedBox(height: 8),

                  Text(
                    'Input your 6 digit transaction PIN to confirm\nyour transaction and authenticate your request',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.encodeSans(
                      fontSize: 14,
                      color: RoqquColors.textSecondary,
                    ),
                  ),
                  Expanded(
                    child: KeypadWidget(
                      onSubmit: (String pin) async {
                        await Future.delayed(const Duration(milliseconds: 550));
                        controller.copyTrader(trader: trader, amount: amount);
                        await Future.delayed(const Duration(milliseconds: 250));

                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CopySuccessScreen(trader: trader),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Text(
                    'Forgot PIN?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.encodeSans(
                      fontSize: 14,
                      color: RoqquColors.link,
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
