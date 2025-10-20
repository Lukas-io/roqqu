import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/constants.dart';
import '../../core/theme/color.dart';

class NewsPreviewWidget extends StatelessWidget {
  const NewsPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final newsItems = [
      NewsItem(
        source: 'TechCabal',
        title: 'Moonshot 2025 Memos: Follow how Africa is building momentum',
        readTime: '4 min read • 4hrs ago',
        imageUrl:
            'https://c76c7bbc41.mjedge.net/wp-content/uploads/tc/2025/10/WhatsApp-Image-2025-10-13-at-11.12.02.jpeg',
      ),
      NewsItem(
        source: 'TechCabal',
        title:
            'Digital Nomads: A Delaware incorporation does not make a startup global. So what does?',
        readTime: '7 min read • 40hrs ago',
        imageUrl:
            'https://c76c7bbc41.mjedge.net/wp-content/uploads/tc/2025/09/andres-garcia-y_m-ivYJd94-unsplash.jpg',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: RoqquConstants.horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
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
              const Spacer(),
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
          const SizedBox(height: 16),

          // News Items
          for (final item in newsItems) ...[
            _NewsCard(item: item),
            const SizedBox(height: 16),
          ],

          // Disclaimer
          Text(
            'This section contains third party content which we have not verified, kindly do not make investment decisions based on the information provided under this section.',
            style: TextStyle(fontSize: 13, color: RoqquColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final NewsItem item;

  const _NewsCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RoqquColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RoqquColors.border),
      ),
      child: Row(
        children: [
          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.source,
                  style: TextStyle(fontSize: 14, color: RoqquColors.textLink),
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  maxLines: 2,
                  style: GoogleFonts.encodeSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: RoqquColors.text,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.readTime,
                  style: TextStyle(
                    fontSize: 13,
                    color: RoqquColors.textSecondary,
                    letterSpacing: 0.85,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              item.imageUrl,
              width: 160,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 160,
                  height: 100,
                  color: RoqquColors.buttonColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NewsItem {
  final String source;
  final String title;
  final String readTime;
  final String imageUrl;

  const NewsItem({
    required this.source,
    required this.title,
    required this.readTime,
    required this.imageUrl,
  });
}
