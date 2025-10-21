import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/controller/user_controller.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/core/constants.dart';
import 'package:roqqu/src/core/utils.dart';
import 'package:roqqu/src/model/copy_trader.dart';
import 'package:roqqu/src/view/transfer/confirm_pin_screen.dart';
import 'package:roqqu/src/view/widgets/dashed_line_divider.dart';

import '../../core/theme/color.dart';
import '../widgets/roqqu_button.dart';

class ConfirmTransactionScreen extends StatelessWidget {
  final double amount;
  final CopyTrader trader;

  const ConfirmTransactionScreen(
    this.amount, {
    super.key,
    required this.trader,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirm transaction",
          style: TextStyle(color: RoqquColors.text, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: RoqquConstants.horizontalPadding,
                vertical: 12,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: RoqquColors.card,
                      border: Border.all(color: RoqquColors.border),
                      borderRadius: BorderRadiusGeometry.circular(8.0),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          RoqquAssets.usFlagSvg,
                          width: 56,
                          height: 56,
                        ),
                        SizedBox(height: 16),

                        Text(
                          'Copy trading amount',
                          style: TextStyle(
                            fontSize: 13,
                            color: RoqquColors.textSecondary,
                          ),
                        ),

                        Text(
                          '${format(amount, currency: "", forceCent: true)} USD',
                          style: GoogleFonts.encodeSans(
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            color: RoqquColors.text,
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildRow('PRO trader', trader.name),
                        _buildRow(
                          'What you get',
                          '${format(amount * 0.99, currency: "")} USD',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: DashedLineDivider(color: RoqquColors.border),
                        ),
                        _buildRow(
                          'Transaction fee',
                          '${format(amount * 0.01, currency: "")} USD',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: RoqquColors.card,
              border: Border.all(color: RoqquColors.border, width: 1.2),
            ),
            padding: EdgeInsetsGeometry.all(16.0),
            child: IntrinsicHeight(
              child: RoqquButton(
                text: 'Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ConfirmPinScreen(trader: trader, amount: amount),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13, color: RoqquColors.textSecondary),
          ),
          Text(value, style: TextStyle(fontSize: 13, color: RoqquColors.text)),
        ],
      ),
    );
  }
}
