import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smartcare/config/component/colors.dart';

class ParagraphText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final int maxLines;
  final TextStyle? style;

  const ParagraphText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.fontColor,
      ).merge(style),
    );
  }
}