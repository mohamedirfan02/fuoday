import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final FontWeight fontWeight;
  final double fontSize;
  final Color? color;
  final bool isUnderline;
  final Color? underlineColor;

  const KText({
    super.key,
    required this.text,
    this.textAlign,
    required this.fontWeight,
    required this.fontSize,
    this.color,
    this.isUnderline = false,
    this.underlineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,

      style: GoogleFonts.sora(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        decoration: isUnderline ? TextDecoration.underline : null,
        decorationColor: underlineColor,
      ),
    );
  }
}
