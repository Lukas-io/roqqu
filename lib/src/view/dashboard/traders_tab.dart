import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roqqu/src/view/dashboard/trader_summary_card.dart';

import '../../core/theme/color.dart';
import '../../model/copy_trader.dart';

class TradersTab extends StatefulWidget {
  final String title;

  const TradersTab(this.title, {super.key});

  @override
  State<TradersTab> createState() => _TradersTabState();
}

class _TradersTabState extends State<TradersTab> {
  final RxString query = ''.obs;
  final TextEditingController controller = TextEditingController();
  bool _canRegister = false;
  Timer? _tapTimer;

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
    return Container(
      color: RoqquColors.card,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => TextField(
              cursorColor: RoqquColors.text,
              onTapUpOutside: _onTapUpOutside,
              controller: controller,
              onTapOutside: _onTapDownOutside,
              style: TextStyle(fontSize: 14, color: RoqquColors.text),
              decoration: InputDecoration(
                contentPadding: EdgeInsetsGeometry.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),

                hintText: "Search for ${widget.title}",
                suffixIcon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    // combine scale + fade transition
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: query.value.isEmpty
                      ? const Icon(
                          CupertinoIcons.search,
                          key: ValueKey('searchIcon'),
                          color: RoqquColors.textSecondary,
                        )
                      : InkWell(
                          onTap: () {
                            query.value = "";
                            controller.clear();
                          },
                          child: const Icon(
                            CupertinoIcons.xmark,
                            key: ValueKey('xmark'),
                            color: RoqquColors.textSecondary,
                          ),
                        ),
                ),
                filled: true,
                isDense: true,

                constraints: BoxConstraints(minHeight: 0, maxHeight: 40),
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: RoqquColors.textSecondary,
                  height: 1,
                ),
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => query.value = value,
            ),
          ),
          const SizedBox(height: 16),

          Obx(() {
            final filtered = traders
                .where(
                  (t) =>
                      t.name.toLowerCase().contains(query.value.toLowerCase()),
                )
                .toList();

            if (filtered.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Text(
                      "No traders found",
                      style: TextStyle(color: RoqquColors.text, fontSize: 18),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              );
            }

            return ListView.separated(
              itemCount: filtered.length,
              shrinkWrap: true,

              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return Divider(color: RoqquColors.background);
              },
              itemBuilder: (context, index) {
                final trader = filtered[index];
                return TraderSummaryCard(trader: trader);
              },
            );
          }),
        ],
      ),
    );
  }
}
