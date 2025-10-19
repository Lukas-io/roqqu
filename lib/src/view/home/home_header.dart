import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/assets.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 2,
                horizontal: 16,
              ),
              elevation: 3,
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(120),
              ),
            ),
            child: Row(
              spacing: 2,
              children: [
                Text(
                  "Crypto",
                  style: TextStyle(height: 1, fontWeight: FontWeight.w500),
                ),
                Icon(Icons.keyboard_arrow_down, size: 24),
              ],
            ),
          ),
          Spacer(),
          Material(
            color: Colors.transparent,

            child: InkWell(
              borderRadius: BorderRadius.circular(360),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  RoqquAssets.searchSvg,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(360),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  RoqquAssets.headphonesSvg,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(360),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(
                      RoqquAssets.notificationSvg,
                      height: 20,
                      width: 20,
                    ),

                    // Notification Dot
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 5,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: Color(0xFF767680).withOpacity(0.12),
            borderRadius: BorderRadius.circular(360),

            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(360),

              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 6.0,
                ),
                child: Row(
                  spacing: 4,
                  children: [
                    SvgPicture.asset(
                      RoqquAssets.ukFlagSvg,
                      height: 20,
                      width: 20,
                    ),
                    Icon(Icons.keyboard_arrow_down, size: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
