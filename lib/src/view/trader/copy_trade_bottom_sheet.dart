import 'package:flutter/material.dart';

class CopyTradeBottomSheet extends StatefulWidget {
  const CopyTradeBottomSheet({super.key});

  static void show(context) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const CopyTradeBottomSheet(),
  );

  @override
  State<CopyTradeBottomSheet> createState() => _CopyTradeBottomSheetState();
}

class _CopyTradeBottomSheetState extends State<CopyTradeBottomSheet> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(top: 24, left: 24, right: 24),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header letters E F
              Row(
                children: const [
                  Text(
                    'E',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'F',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Title
              const Text(
                'Important message!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Body
              const Text(
                'Don’t invest unless you’re prepared and understand the risks involved in copy trading. Learn more about the risks.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 16),

              // Checkbox
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Check this box to agree to Roqqu’s copy trading policy',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isChecked
                          ? () {
                              // Proceed action
                              Navigator.pop(context);
                            }
                          : null,
                      child: const Text('Proceed to copy trade'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Direct deposit action
                      },
                      child: const Text('Direct deposit'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
