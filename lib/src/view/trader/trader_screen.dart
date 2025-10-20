import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/constants.dart';
import 'package:roqqu/src/model/copy_trader.dart';
import 'package:roqqu/src/view/trader/trader_header.dart';

import '../../core/theme/color.dart';

class TraderScreen extends StatelessWidget {
  final CopyTrader trader;

  const TraderScreen({super.key, required this.trader});

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trading details",
          style: TextStyle(color: RoqquColors.text, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(RoqquConstants.horizontalPadding),

        child: Column(children: [TraderHeader(trader)]),
      ),
    );
  }
}
