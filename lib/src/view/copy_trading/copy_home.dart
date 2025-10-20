import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/constants.dart';
import 'package:roqqu/src/model/copy_trader.dart';
import 'package:roqqu/src/view/copy_trading/copy_home_header.dart';
import 'package:roqqu/src/view/copy_trading/copy_trader_card.dart';

import '../../core/theme/color.dart';

class CopyHome extends StatelessWidget {
  const CopyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Copy trading",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CopyHomeHeader(),
              SizedBox(height: 32),
              Text(
                "PRO Traders",
                style: GoogleFonts.encodeSans(
                  fontSize: 16,
                  height: 1,
                  color: RoqquColors.text,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12),

              Column(
                spacing: 16,
                children: traders
                    .map((trader) => CopyTraderCard(trader: trader))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
