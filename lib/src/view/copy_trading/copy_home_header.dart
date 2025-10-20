import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/view/dashboard/dashboard.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
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

class CopyHomeOptionItem extends StatefulWidget {
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
  State<CopyHomeOptionItem> createState() => _CopyHomeOptionItemState();
}

class _CopyHomeOptionItemState extends State<CopyHomeOptionItem>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.95);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.backgroundImage),
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
                child: SvgPicture.asset(widget.iconPath, width: 16, height: 16),
              ),
              const SizedBox(height: 24),
              Text(
                widget.title,
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
                    widget.subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: RoqquColors.background,
                    ),
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
      ),
    );
  }
}
