import 'package:flutter/material.dart';

/// Widget for title text
class IconText extends StatelessWidget {
  /// ctor.
  const IconText(this.data);

  /// Texst to be displayed.
  final String data;

  @override
  Widget build(BuildContext context) => Text(
        data,
        style: const TextStyle(color: Color(0xff2196f3)),
      );
}
