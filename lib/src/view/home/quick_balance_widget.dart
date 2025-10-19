import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/core/constants.dart';
import 'package:roqqu/src/core/theme/color.dart';

enum QuickActions {
  deposit('Deposit', RoqquAssets.depositSvg),
  buy('Buy', RoqquAssets.buySvg),
  withdraw('Withdraw', RoqquAssets.withdrawSvg),
  sell('Sell', RoqquAssets.sendSvg);

  final String label;
  final String icon;

  const QuickActions(this.label, this.icon);
}

class QuickBalanceWidget extends StatefulWidget {
  const QuickBalanceWidget({super.key});

  @override
  State<QuickBalanceWidget> createState() => _QuickBalanceWidgetState();
}

class _QuickBalanceWidgetState extends State<QuickBalanceWidget> {
  final showBalance = false.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: RoqquConstants.horizontalPadding,
      ),
      child: Column(
        children: [
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your GBP Balance",
                style: TextStyle(color: RoqquColors.textSecondary),
              ),
              Obx(
                () => InkWell(
                  onTap: () {
                    showBalance.value = !showBalance.value;
                  },
                  borderRadius: BorderRadius.circular(360),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SvgPicture.asset(
                      showBalance.value
                          ? RoqquAssets.eyeSvg
                          : RoqquAssets.eyeSlashSvg,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => InkWell(
              onTap: () {
                showBalance.value = !showBalance.value;
              },
              splashColor: Colors.transparent,
              child: RichText(
                text: TextSpan(
                  text: showBalance.value ? '£0' : '***',

                  style: GoogleFonts.encodeSans(
                    color: RoqquColors.text,

                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                  ),
                  children: [
                    TextSpan(
                      text: showBalance.value ? '.00' : '',
                      style: GoogleFonts.encodeSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: RoqquColors.card,
              borderRadius: BorderRadiusGeometry.circular(24),
              border: Border.all(color: RoqquColors.border, width: 1.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: QuickActions.values
                  .map(
                    (action) => Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          vertical: 12,
                          horizontal: 4,
                        ),
                        child: Column(
                          spacing: 4,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: RoqquColors.background,
                              ),
                              padding: EdgeInsets.all(16),
                              child: SvgPicture.asset(action.icon),
                            ),
                            Text(
                              action.label,
                              style: TextStyle(
                                fontSize: 13,
                                color: RoqquColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
            decoration: BoxDecoration(
              color: RoqquColors.card,
              border: const Border(
                left: BorderSide(color: RoqquColors.border, width: 1.2),
                right: BorderSide(color: RoqquColors.border, width: 1.2),
                bottom: BorderSide(color: RoqquColors.border, width: 1.2),
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              'See more',
              style: TextStyle(
                fontSize: 12,
                color: RoqquColors.textLink,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
