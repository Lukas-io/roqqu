import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/core/constants.dart';
import 'package:roqqu/src/core/theme/color.dart';
import 'package:roqqu/src/view/copy_trading/comfortable_risk_screen.dart';

import '../widgets/roqqu_button.dart';

class GetStartedCopyTrading extends StatefulWidget {
  const GetStartedCopyTrading({super.key});

  @override
  State<GetStartedCopyTrading> createState() => _GetStartedCopyTradingState();
}

class _GetStartedCopyTradingState extends State<GetStartedCopyTrading> {
  final showIndicator = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Copy trading",
          style: TextStyle(color: RoqquColors.text, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: RoqquConstants.horizontalPadding,
              ),
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: Container(color: RoqquColors.link, height: 2),
                  ),
                  Expanded(
                    child: Container(
                      color: showIndicator.value
                          ? RoqquColors.link
                          : RoqquColors.border,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                showIndicator.value = index > 0;
              },
              children: [
                CopyTradingPage(
                  title: 'Copy PRO traders',
                  subtitle:
                      'Leverage expert strategies from professional traders to boost your trading results.',
                  imagePath: RoqquAssets.copyTrading1Image,
                ),
                CopyTradingPage(
                  title: 'Do less, Win more',
                  subtitle:
                      'Streamline your approach to trading and increase your winning potential effortlessly.',
                  imagePath: RoqquAssets.copyTrading2Image,
                ),
              ],
            ),
          ),

          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 20.0,
              ),
              child: Text(
                'Watch a how to video',
                style: TextStyle(fontSize: 16, color: RoqquColors.link),
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: RoqquColors.card,
              border: Border.all(color: RoqquColors.border, width: 1.2),
            ),
            padding: EdgeInsetsGeometry.all(16.0),
            child: RoqquButton(
              text: 'Get started',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComfortableRiskScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CopyTradingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const CopyTradingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            title,
            style: GoogleFonts.encodeSans(
              fontSize: 24,
              color: RoqquColors.text,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              height: 1.25,
              color: RoqquColors.textSecondary,
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentGeometry.center,
              child: Image.asset(imagePath),
            ),
          ),
        ],
      ),
    );
  }
}
