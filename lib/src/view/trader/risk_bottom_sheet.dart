import 'package:flutter/material.dart';

class RiskBottomSheet extends StatelessWidget {
  const RiskBottomSheet({super.key});

  static void show(context) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const RiskBottomSheet(),
  );

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(16),
            children: const [
              Text(
                'Risks involved in copy trading',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Please make sure you read the following risks involved in copy trading before making a decision.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              SizedBox(height: 16),

              // Risk items as custom expansion tiles
              CustomRiskTile(
                title: 'Market risks',
                content:
                    'All investments carry risks, including potential loss of capital.',
              ),
              CustomRiskTile(
                title: 'Dependency on others',
                content:
                    'Your profits may depend on the decisions of other traders.',
              ),
              CustomRiskTile(
                title: 'Mismatched risk profiles',
                content:
                    'Ensure your risk tolerance matches the trader you copy.',
              ),
              CustomRiskTile(
                title: 'Control and understanding',
                content:
                    'Copy trading requires understanding of strategies and controls.',
              ),
              CustomRiskTile(
                title: 'Emotional decisions',
                content:
                    'Avoid making impulsive decisions based on short-term market moves.',
              ),
              CustomRiskTile(
                title: 'Costs involved',
                content:
                    'Fees or spreads may apply, affecting overall returns.',
              ),
              CustomRiskTile(
                title: 'Diversify',
                content: 'Spread your investments to reduce risk exposure.',
              ),
              CustomRiskTile(
                title: 'Execution risks',
                content:
                    'Copy trading investments can be complex and may not execute as expected.',
              ),
              CustomRiskTile(
                title: 'I have read the risks',
                content: 'Check this box to confirm you understand the risks.',
                isCheckbox: true,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------- Custom Risk Tile ----------------

class CustomRiskTile extends StatefulWidget {
  final String title;
  final String content;
  final bool isCheckbox;

  const CustomRiskTile({
    super.key,
    required this.title,
    required this.content,
    this.isCheckbox = false,
  });

  @override
  State<CustomRiskTile> createState() => _CustomRiskTileState();
}

class _CustomRiskTileState extends State<CustomRiskTile>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: () {
          if (!widget.isCheckbox) {
            setState(() {
              isExpanded = !isExpanded;
            });
          } else {
            setState(() {
              isChecked = !isChecked;
            });
          }
        },
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: widget.isCheckbox
                          ? Checkbox(
                              value: isChecked,
                              onChanged: (val) {
                                setState(() {
                                  isChecked = val ?? false;
                                });
                              },
                              key: ValueKey(isChecked),
                            )
                          : Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              key: ValueKey(isExpanded),
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                if (!widget.isCheckbox)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isExpanded
                        ? Text(
                            widget.content,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
