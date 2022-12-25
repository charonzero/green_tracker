// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class WrappingIconData extends StatelessWidget {
  const WrappingIconData({
    Key? key,
    required this.size,
    this.text = '',
    required this.value,
    required this.icon,
    this.style = const TextStyle(color: Colors.black),
    this.icon_size_multiplyer = 1.0,
  }) : super(key: key);

  final Size size;
  final String text;
  final InlineSpan value;
  final IconData icon;
  final TextStyle style;
  final double icon_size_multiplyer;
  @override
  Widget build(BuildContext context) {
    return RichText(
        maxLines: 1,
        textAlign: TextAlign.center,
        text: TextSpan(
          style: style,
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                icon,
                size: 15 * icon_size_multiplyer,
                color: Colors.amber,
              ),
            ),
            TextSpan(
              text: ' $text',
            ),
            value
          ],
        ));
  }
}
