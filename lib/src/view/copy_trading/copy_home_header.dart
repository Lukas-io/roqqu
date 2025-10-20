import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/assets.dart';

import '../../core/theme/color.dart';

class CopyHomeHeader extends StatelessWidget {
  const CopyHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: CopyHomeOptionItem(
            title: "My dashboard",
            subtitle: "View trades",
            iconPath: RoqquAssets.copyDashboardSvg,
            backgroundImage: RoqquAssets.dashboardImage,
            onTap: () {
              // handle navigation
            },
          ),
        ),
        Expanded(
          child: CopyHomeOptionItem(
            title: "Become a PRO trader",
            subtitle: "Apply Now",
            iconPath: RoqquAssets.proTraderSvg,
            backgroundImage: RoqquAssets.traderImage,
            onTap: () {
              // handle navigation
            },
          ),
        ),
      ],
    );
  }
}

class CopyHomeOptionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;
  final String backgroundImage;
  final VoidCallback? onTap;

  const CopyHomeOptionItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.backgroundImage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            CircleAvatar(
              backgroundColor: RoqquColors.background,
              radius: 18,
              child: SvgPicture.asset(iconPath, width: 16, height: 16),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              maxLines: 1,
              style: GoogleFonts.encodeSans(
                fontSize: 13,
                height: 1,
                color: RoqquColors.background,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: RoqquColors.background),
                ),
                const Spacer(),
                const Icon(
                  Icons.keyboard_arrow_right,
                  size: 24,
                  color: RoqquColors.background,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
