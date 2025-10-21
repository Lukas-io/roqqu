import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roqqu/src/controller/user_controller.dart';
import 'package:roqqu/src/model/copy_trader.dart';
import 'package:roqqu/src/view/transfer/confirm_transaction_screen.dart';

import '../../core/assets.dart';
import '../../core/constants.dart';
import '../../core/theme/color.dart';
import '../../core/utils.dart';
import '../widgets/roqqu_button.dart';
import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalRange; // number of allowed decimal places

  DecimalTextInputFormatter({required this.decimalRange})
    : assert(decimalRange >= 0);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    if (text == '') {
      return newValue;
    }

    // Allow only digits and a single dot
    if (!RegExp(r'^\d*\.?\d*$').hasMatch(text)) {
      return oldValue;
    }

    if (text.contains('.')) {
      final parts = text.split('.');
      // prevent multiple dots
      if (parts.length > 2) return oldValue;
      // enforce decimal places
      if (parts[1].length > decimalRange) return oldValue;
    }

    return newValue;
  }
}

class EnterAmountScreen extends StatefulWidget {
  final CopyTrader trader;

  const EnterAmountScreen({super.key, required this.trader});

  @override
  State<EnterAmountScreen> createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends State<EnterAmountScreen> {
  late final TextEditingController textEditingController;
  late final FocusNode node;
  final RxDouble amount = 10.0.obs;

  bool _canRegister = false;
  Timer? _tapTimer;

  @override
  void initState() {
    textEditingController = TextEditingController(text: "10");
    node = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }

  void _onTapDownOutside(PointerDownEvent event) {
    _canRegister = true;

    _tapTimer?.cancel();
    _tapTimer = Timer(const Duration(milliseconds: 200), () {
      _canRegister = false;
    });
  }

  void _onTapUpOutside(PointerUpEvent event) {
    if (_canRegister) {
      onTapOutside();
      _canRegister = false;
      _tapTimer?.cancel();
    }
  }

  void onTapOutside() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter amount",
          style: TextStyle(color: RoqquColors.text, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF20252B),
              borderRadius: BorderRadius.circular(360),
              border: Border.all(color: RoqquColors.border),
            ),
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
                      RoqquAssets.usFlagSvg,
                      height: 20,
                      width: 20,
                    ),
                    Text(
                      "USD",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: RoqquColors.text,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTap: () => node.requestFocus(),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Spacer(flex: 2),

                      // Obx(
                      //   () =>
                      TextField(
                        controller: textEditingController,
                        focusNode: node,
                        autofocus: true,
                        clipBehavior: Clip.none,

                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          hintStyle: GoogleFonts.encodeSans(
                            fontSize: 40,
                            color: RoqquColors.textSecondary,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                          hintText: "0",
                        ),
                        textAlign: TextAlign.center,

                        cursorColor: RoqquColors.text,
                        inputFormatters: [
                          DecimalTextInputFormatter(decimalRange: 2),
                        ],
                        style: GoogleFonts.encodeSans(
                          fontSize: 40,
                          height: 1,
                          color: RoqquColors.text,
                          fontWeight: FontWeight.w700,
                        ),
                        onChanged: (value) {
                          // value.replaceAll("USD", "");
                          final money = double.tryParse(value) ?? 0.0;
                          if (money > controller.balance) {
                            textEditingController.text = controller.balance
                                .toString();
                            amount.value = controller.balance;
                          } else {
                            amount.value = money;
                          }
                          // textEditingController.text = value + " USD";
                        },
                      ),
                      Text(
                        "USD",
                        style: GoogleFonts.encodeSans(
                          fontSize: 12,
                          color: RoqquColors.text,
                          fontWeight: FontWeight.w600,
                          height: 2,
                        ),
                      ),
                      SizedBox(height: 16),
                      // ),
                      Obx(
                        () => Container(
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: RoqquConstants.horizontalPadding,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: RoqquColors.card,
                            borderRadius: BorderRadiusGeometry.circular(16),
                            border: Border.all(color: RoqquColors.border),
                          ),

                          child: AnimatedSize(
                            duration: 300.ms,
                            clipBehavior: Clip.none,
                            child: Text(
                              'Transaction fee (1%) - ${format(amount.value * 0.01, currency: "")} USD',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: RoqquColors.text,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(flex: 3),
                      Container(
                        padding: EdgeInsetsGeometry.symmetric(
                          horizontal: RoqquConstants.horizontalPadding,
                          vertical: 12,
                        ),
                        margin: EdgeInsetsGeometry.symmetric(
                          horizontal: RoqquConstants.horizontalPadding,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: RoqquColors.card,
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),

                        child: Row(
                          children: [
                            Column(
                              spacing: 2,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'USD Balance',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: RoqquColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  format(controller.balance, forceCent: true),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: RoqquColors.text,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                textEditingController.text = controller.balance
                                    .toString();
                                amount.value = controller.balance;
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: RoqquColors.buttonColor,
                                minimumSize: Size.zero,

                                padding: EdgeInsetsGeometry.symmetric(
                                  vertical: 6,
                                  horizontal: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    800,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Use Max",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: RoqquColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: RoqquColors.card,
                    border: Border.all(color: RoqquColors.border, width: 1.2),
                  ),
                  padding: EdgeInsetsGeometry.all(16.0),
                  child: Obx(
                    () => RoqquButton(
                      text: 'Continue',
                      onPressed: amount.value <= 0
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ConfirmTransactionScreen(
                                        amount.value,
                                        trader: widget.trader,
                                      ),
                                ),
                              );
                            },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
