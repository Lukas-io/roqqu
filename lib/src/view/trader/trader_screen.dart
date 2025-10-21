import 'package:flutter/material.dart';
import 'package:roqqu/src/core/constants.dart';
import 'package:roqqu/src/model/copy_trader.dart';
import 'package:roqqu/src/view/trader/copy_trade_bottom_sheet.dart';
import 'package:roqqu/src/view/trader/trader_content.dart';
import 'package:roqqu/src/view/trader/trader_header.dart';

import '../../core/theme/color.dart';
import '../widgets/roqqu_button.dart';

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
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsetsGeometry.all(RoqquConstants.horizontalPadding),
              child: Column(
                spacing: 12,
                children: [TraderHeader(trader), TraderContent(trader)],
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
                text: 'Copy trade',
                onPressed: () {
                  CopyTradeBottomSheet.show(context, trader);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
