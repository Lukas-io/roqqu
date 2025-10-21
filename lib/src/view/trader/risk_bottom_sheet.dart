import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/color.dart';
import '../widgets/roqqu_button.dart';

class RiskBottomSheet extends StatefulWidget {
  const RiskBottomSheet({super.key});

  static void show(context) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    builder: (_) => const RiskBottomSheet(),
  );

  @override
  State<RiskBottomSheet> createState() => _RiskBottomSheetState();
}

class _RiskBottomSheetState extends State<RiskBottomSheet> {
  final risks = [
    CustomRiskTile(
      title: 'Market risks',
      content:
          'All investments carry risks, including potential loss of capital.',
    ),
    CustomRiskTile(
      title: 'Dependency on others',
      content: 'Your profits may depend on the decisions of other traders.',
    ),
    CustomRiskTile(
      title: 'Mismatched risk profiles',
      content: 'Ensure your risk tolerance matches the trader you copy.',
    ),
    CustomRiskTile(
      title: 'Control and understanding',
      content:
          'Copy trading requires understanding of strategies and controls.',
    ),
    CustomRiskTile(
      title: 'Emotional decisions',
      content:
          'Avoid making impulsive decisions based on short-term market moves.',
    ),
    CustomRiskTile(
      title: 'Costs involved',
      content: 'Fees or spreads may apply, affecting overall returns.',
    ),
    CustomRiskTile(
      title: 'Diversify',
      content: 'Spread your investments to reduce risk exposure.',
    ),
    CustomRiskTile(
      title: 'Execution risks',
      content:
          'Copy trading investments can be complex and may not execute as expected.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.5,
      snap: true,
      snapSizes: [0.7, 0.85],
      maxChildSize: 0.9,
      builder: (_, controller) {
        return Material(
          type: MaterialType.transparency,

          child: Container(
            decoration: const BoxDecoration(
              color: RoqquColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
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

                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 32),
                        Text(
                          'Risks involved in copy trading',
                          style: GoogleFonts.encodeSans(
                            fontSize: 20,
                            color: RoqquColors.text,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            'Please make sure you read the following risks involved in copy trading before making a decision.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: RoqquColors.textSecondary,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Expanded(
                          child: ListView.separated(
                            controller: controller,
                            padding: EdgeInsetsGeometry.symmetric(vertical: 12),
                            itemBuilder: (context, index) => risks[index],
                            separatorBuilder:
                                (BuildContext context, int index) {
                                  return Divider(color: RoqquColors.border);
                                },
                            itemCount: risks.length,
                          ),
                        ),
                        RoqquButton(
                          text: "I have read the risks",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---------------- Custom Risk Tile ----------------

class CustomRiskTile extends StatefulWidget {
  final String title;
  final String content;

  const CustomRiskTile({super.key, required this.title, required this.content});

  @override
  State<CustomRiskTile> createState() => _CustomRiskTileState();
}

class _CustomRiskTileState extends State<CustomRiskTile>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: AlignmentGeometry.topCenter,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),

              if (isExpanded) ...[
                const SizedBox(height: 12),
                Text(
                  widget.content,
                  style: const TextStyle(
                    fontSize: 14,
                    color: RoqquColors.textSecondary,
                  ),
                ),
              ] else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
