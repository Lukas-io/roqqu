import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/core/assets.dart';
import 'package:roqqu/src/core/theme/color.dart';

import '../../service/biometrics_service.dart';

class KeypadWidget extends StatefulWidget {
  final void Function(String) onSubmit;
  final int pinLength;

  const KeypadWidget({super.key, required this.onSubmit, this.pinLength = 6});

  @override
  State<KeypadWidget> createState() => _KeypadWidgetState();
}

class _KeypadWidgetState extends State<KeypadWidget> {
  final keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '.', '0', '⌫'];
  final RxString pin = "".obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 12),
          child: Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: RoqquColors.card,
                  border: Border.all(color: RoqquColors.border),
                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
                child: Obx(
                  () => Row(
                    spacing: 10,
                    children: List.generate(
                      widget.pinLength,
                      (index) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index >= pin.value.length
                              ? RoqquColors.buttonColor
                              : RoqquColors.text,
                        ),
                        height: 14,
                        width: 14,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  final result = await BiometricsService().authenticate(
                    localizedReason: 'Authenticate your transaction',
                  );

                  if (result.success) {
                    pin.value = "";
                    for (int i = 0; i < widget.pinLength; i++) {
                      pin.value += "1";
                      await Future.delayed(const Duration(milliseconds: 50));
                    }

                    widget.onSubmit("biometrics");
                  } else {
                    log('Failed: ${result.errorMessage}');
                  }
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: RoqquColors.card,
                    border: Border.all(color: RoqquColors.border),
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                  child: SvgPicture.asset(
                    RoqquAssets.biometricsSvg,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: keys.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              final key = keys[index];
              final isBackspace = key == '⌫';

              return InkWell(
                onTap: () {
                  if (isBackspace) {
                    if (pin.isEmpty) return;
                    pin.value = pin.substring(0, pin.value.length - 1);
                  } else {
                    pin.value += key;
                  }
                  if (pin.value.length >= widget.pinLength) {
                    widget.onSubmit(pin.substring(0, widget.pinLength));
                  }
                },
                child: Align(
                  alignment: Alignment.center,
                  child: isBackspace
                      ? SvgPicture.asset(RoqquAssets.backArrowSvg)
                      : Text(
                          key,
                          style: GoogleFonts.encodeSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: RoqquColors.text,
                          ),
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
