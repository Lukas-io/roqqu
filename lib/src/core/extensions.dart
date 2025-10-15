import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  Future push(Widget screen) {
    return Navigator.push(this, MaterialPageRoute(builder: (_) => screen));
  }

  Future pushReplacement(Widget screen) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (_) => screen),
    );
  }
}
