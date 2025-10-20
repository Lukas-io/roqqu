import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/core/constants.dart';

import '../../core/theme/color.dart';

class ReferFriendBanner extends StatelessWidget {
  const ReferFriendBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: RoqquColors.card,
        borderRadius: BorderRadiusGeometry.circular(16),
        border: Border.all(color: RoqquColors.border),
      ),
      padding: EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 16),
      margin: EdgeInsetsGeometry.symmetric(
        horizontal: RoqquConstants.horizontalPadding,
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Refer friends to Roqqu',
                    maxLines: 2,
                    style: GoogleFonts.encodeSans(
                      fontSize: 18,
                      height: 1,
                      fontWeight: FontWeight.w700,
                      color: RoqquColors.text,
                    ),
                  ),
                ),
                Text(
                  'Invite your friends and family to enjoy Roqqu with your code and earn money',
                  style: TextStyle(
                    fontSize: 13,
                    color: RoqquColors.textSecondary,
                  ),
                ),

                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsetsGeometry.only(top: 8.0),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 13,
                            color: RoqquColors.textLink,
                            letterSpacing: 0.85,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          size: 24,
                          color: RoqquColors.textLink,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),

          Image.asset(RoqquAssets.mascotImage, height: 100, width: 90),
        ],
      ),
    );
  }
}
