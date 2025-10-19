import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/constants.dart';
import 'package:roqqu/src/core/theme/color.dart';

import '../../core/assets.dart';

enum UpdatesData {
  coins(
    title: 'Delisting Coins',
    subtitle: 'View the list of coins we are delisting',
    icon: RoqquAssets.notificationBannerSvg,
    isUrgent: true,
  ),
  rates(
    title: 'Exchange Rates',
    subtitle: 'View all currency rates at a glance',
    icon: RoqquAssets.swapSvg,
    isUrgent: false,
  ),
  expansion(
    title: 'Roqqu Expands to Europe',
    subtitle: 'We are now on the shores of Europe!',
    icon: RoqquAssets.swapSvg,
    isUrgent: false,
  );

  final String title;
  final String subtitle;
  final String icon;
  final bool isUrgent;

  const UpdatesData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isUrgent,
  });
}

class UpdatesScrollView extends StatelessWidget {
  const UpdatesScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: RoqquConstants.horizontalPadding),
          child: Text(
            'Stay Updated',
            style: GoogleFonts.encodeSans(
              fontSize: 14,
              color: RoqquColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: RoqquConstants.horizontalPadding,
          ),
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 16,
            children: UpdatesData.values
                .map((update) => _UpdatesCard(update))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _UpdatesCard extends StatelessWidget {
  final UpdatesData data;

  const _UpdatesCard(this.data);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),

      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: RoqquColors.card,
              border: Border.all(color: RoqquColors.border, width: 1.2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                SvgPicture.asset(data.icon, height: 24, width: 24),
                const SizedBox(width: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: GoogleFonts.encodeSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: RoqquColors.text,
                      ),
                    ),
                    Text(
                      data.subtitle,
                      style: const TextStyle(
                        color: RoqquColors.textSecondary,

                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
              ],
            ),
          ),

          // Urgent banner (if applicable)
          if (data.isUrgent)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: RoqquColors.error.withOpacity(0.07),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: const Text(
                  'Urgent Notice',
                  style: TextStyle(color: RoqquColors.error, fontSize: 13),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
