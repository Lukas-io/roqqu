import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/core/theme/color.dart';
import 'package:roqqu/src/model/copy_trader.dart';
import 'package:roqqu/src/view/trader/risk_bottom_sheet.dart';
import 'package:roqqu/src/view/widgets/roqqu_button.dart';

import '../transfer/enter_amount_screen.dart';

class CopyTradeBottomSheet extends StatefulWidget {
  final CopyTrader trader;

  const CopyTradeBottomSheet({super.key, required this.trader});

  static void show(context, CopyTrader trader) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (_) => CopyTradeBottomSheet(trader: trader),
  );

  @override
  State<CopyTradeBottomSheet> createState() => _CopyTradeBottomSheetState();
}

class _CopyTradeBottomSheetState extends State<CopyTradeBottomSheet> {
  RxBool isChecked = false.obs;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: RoqquColors.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(color: RoqquColors.border),
          ),
          child: SafeArea(
            child: Stack(
              alignment: AlignmentGeometry.bottomCenter,
              children: [
                Positioned(
                  top: 12,
                  right: 12,
                  child: IconButton.filled(
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(
                      padding: EdgeInsetsGeometry.all(8),

                      minimumSize: Size.zero,
                      backgroundColor: RoqquColors.buttonColor,
                    ),
                    icon: Icon(
                      CupertinoIcons.xmark,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 24,
                    horizontal: 18,
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 24),
                      Image.asset(
                        RoqquAssets.importantMessageImage,
                        height: 128,
                        width: 128,
                      ),
                      Text(
                        'Important message!',
                        style: GoogleFonts.encodeSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'Don’t invest unless you’re prepared and understand the risks involved in copy trading. ',
                            style: TextStyle(
                              color: RoqquColors.textSecondary,
                              fontSize: 15,
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(
                                text: '\nLearn more',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => RiskBottomSheet.show(context),
                                style: TextStyle(
                                  color: RoqquColors.link,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500,
                                  height: 1.75,
                                ),
                              ),
                              TextSpan(text: ' about the risks.'),
                            ],
                          ),
                        ),
                      ),
                      const Text(
                        '',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      const SizedBox(height: 16),

                      // Checkbox
                      InkWell(
                        onTap: () => isChecked.value = !isChecked.value,

                        child: Row(
                          spacing: 16,
                          children: [
                            Obx(
                              () => InkWell(
                                onTap: () => isChecked.value = !isChecked.value,

                                child: Container(
                                  decoration: BoxDecoration(
                                    color: RoqquColors.buttonColor,
                                    borderRadius: BorderRadiusGeometry.circular(
                                      8,
                                    ),
                                    border: Border.all(
                                      color: RoqquColors.border,
                                    ),
                                  ),
                                  padding: EdgeInsetsGeometry.all(4),
                                  child: !isChecked.value
                                      ? SizedBox(height: 16, width: 16)
                                      : Icon(Icons.check_rounded, size: 16),
                                ),
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      'Check this box to agree to Roqqu’s copy trading',
                                  style: GoogleFonts.encodeSans(
                                    color: RoqquColors.text,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' policy',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      style: GoogleFonts.encodeSans(
                                        color: RoqquColors.link,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Obx(
                        () => RoqquButton(
                          text: "Proceed to copy trade",
                          onPressed: !isChecked.value
                              ? null
                              : () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EnterAmountScreen(
                                        trader: widget.trader,
                                      ),
                                    ),
                                  );
                                },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
