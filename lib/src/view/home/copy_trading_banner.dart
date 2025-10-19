import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/core/constants.dart';
import 'package:roqqu/src/core/theme/color.dart';

class CopyTradingBanner extends StatelessWidget {
  const CopyTradingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(16),
        gradient: LinearGradient(
          colors: [
            Color(0xFFFEC536), // 0%
            Color(0xFF98AAFE), // 44%
            Color(0xFF6179FA), // 100%
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.0, 0.44, 1.0],
        ),
      ),
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsetsGeometry.symmetric(
        horizontal: RoqquConstants.horizontalPadding,
      ),
      padding: EdgeInsets.all(1),
      width: double.infinity,

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(16),

          gradient: LinearGradient(
            colors: [
              Color(0xFFABE2F3), // 0%
              Color(0xFFBDE4E5), // 39%
              Color(0xFFEBE9D0), // 100%
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.39, 1.0],
          ),
        ),

        width: double.infinity,
        padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 12),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 72.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Copy Trading',
                    style: GoogleFonts.encodeSans(
                      fontSize: 18,
                      color: RoqquColors.textBlack,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),

                  Text(
                    'Discover our latest feature. Follow and watch the PRO traders closely and win like a PRO! We are rooting for you!',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      color: RoqquColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),
            Positioned(
              bottom: -20,
              right: -30,
              child: Image.asset(
                RoqquAssets.crownImage,
                width: 110,
                height: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
