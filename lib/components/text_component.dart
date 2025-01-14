import 'package:flutter/widgets.dart';

class TextComponent extends StatelessWidget {
  const TextComponent({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
    this.fontFamily = '',
    this.fontWeight = FontWeight.normal,
  });
  final String text;
  final Color color;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
