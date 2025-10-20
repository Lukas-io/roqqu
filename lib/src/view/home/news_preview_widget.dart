import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/constants.dart';

import '../../core/theme/color.dart';

class NewsPreviewWidget extends StatelessWidget {
  const NewsPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: RoqquConstants.horizontalPadding,
      ),
      child: Column(
        spacing: 16,
        children: [
          Row(
            children: [
              Text(
                "Also in the news",
                style: GoogleFonts.encodeSans(
                  fontSize: 14,
                  color: RoqquColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Text(
                'See all',
                style: TextStyle(
                  fontSize: 13,
                  color: RoqquColors.textLink,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsetsGeometry.all(16),
            decoration: BoxDecoration(
              color: RoqquColors.card,
              borderRadius: BorderRadiusGeometry.circular(16),
              border: Border.all(color: RoqquColors.border),
            ),
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TechCabal',
                        style: TextStyle(
                          fontSize: 14,
                          color: RoqquColors.textLink,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Moonshot 2025 Memos: Follow how Africa is building momentum',
                          maxLines: 2,
                          style: GoogleFonts.encodeSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: RoqquColors.text,
                          ),
                        ),
                      ),
                      Text(
                        '4 min read • 4hrs ago',
                        style: TextStyle(
                          fontSize: 13,
                          color: RoqquColors.textSecondary,
                          letterSpacing: 0.85,
                        ),
                      ),
                    ],
                  ),
                ),

                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(4),
                  child: Image.network(
                    "https://c76c7bbc41.mjedge.net/wp-content/uploads/tc/2025/10/WhatsApp-Image-2025-10-13-at-11.12.02.jpeg",
                    width: 160,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsetsGeometry.all(16),
            decoration: BoxDecoration(
              color: RoqquColors.card,
              borderRadius: BorderRadiusGeometry.circular(16),
              border: Border.all(color: RoqquColors.border),
            ),
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TechCabal',
                        style: TextStyle(
                          fontSize: 14,
                          color: RoqquColors.textLink,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Digital Nomads: A Delaware incorporation does not make a startup global. So what does?',
                          maxLines: 2,
                          style: GoogleFonts.encodeSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: RoqquColors.text,
                          ),
                        ),
                      ),
                      Text(
                        '7 min read • 40hrs ago',
                        style: TextStyle(
                          fontSize: 13,
                          color: RoqquColors.textSecondary,
                          letterSpacing: 0.85,
                        ),
                      ),
                    ],
                  ),
                ),

                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(4),
                  child: Image.network(
                    "https://c76c7bbc41.mjedge.net/wp-content/uploads/tc/2025/09/andres-garcia-y_m-ivYJd94-unsplash.jpg",
                    width: 160,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'This section contains third party content which we have not verified, kindly do not make investment decisions based on the information provided under this section.',
            style: TextStyle(fontSize: 13, color: RoqquColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
