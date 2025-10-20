import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/view/copy_trading/copy_home.dart';

import '../../core/theme/color.dart';
import '../widgets/roqqu_button.dart';

enum RiskLevel {
  conservative(
    'Conservative profile',
    'Conservative profile involves stable returns from proven strategies with minimal volatility.',
  ),
  steadyGrowth(
    'Steady growth profile',
    'Steady growth involves balanced gains with moderate fluctuations in strategy performance.',
  ),
  exponentialGrowth(
    'Exponential growth profile',
    'It has potentials for significant gains or losses due to aggressive trading and market exposure.',
  );

  final String title;
  final String description;

  const RiskLevel(this.title, this.description);
}

class ComfortableRiskScreen extends StatefulWidget {
  const ComfortableRiskScreen({super.key});

  @override
  State<ComfortableRiskScreen> createState() => _ComfortableRiskScreenState();
}

class _ComfortableRiskScreenState extends State<ComfortableRiskScreen> {
  final selectedRisk = RiskLevel.conservative.obs;

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
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  "What risk level are you comfortable exploring?",
                  style: GoogleFonts.encodeSans(
                    fontSize: 24,
                    color: RoqquColors.text,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "Choose a level",
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.25,
                    color: RoqquColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Obx(
                () => Column(
                  spacing: 24,
                  children: RiskLevel.values
                      .map(
                        (risk) => InkWell(
                          onTap: () {
                            selectedRisk.value = risk;
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              if (selectedRisk.value == risk)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      horizontal: 7,
                                      vertical: 2,
                                    ),

                                    decoration: BoxDecoration(
                                      color: RoqquColors.link,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(16),
                                        bottomLeft: Radius.circular(16),
                                      ),
                                    ),
                                    child: Icon(Icons.check_rounded, size: 18),
                                  ),
                                ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: selectedRisk.value == risk
                                        ? RoqquColors.link
                                        : Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  spacing: 8,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      risk.title,
                                      style: GoogleFonts.encodeSans(
                                        fontSize: 16,
                                        color: RoqquColors.text,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      risk.description,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: RoqquColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: RoqquColors.card,
              border: Border.all(color: RoqquColors.border, width: 1.2),
            ),
            padding: EdgeInsetsGeometry.all(16.0),
            child: RoqquButton(
              text: 'Proceed',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CopyHome()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
