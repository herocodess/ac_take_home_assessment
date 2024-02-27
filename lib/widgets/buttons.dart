import 'package:acumen_technical_assessment/core/utils/colors.dart';
import 'package:acumen_technical_assessment/core/utils/extensions.dart';
import 'package:acumen_technical_assessment/core/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// This file contains all the custom buttons used in the app.
/// [PrimaryButton] is the main button used in the app.
/// [OutlinedPrimaryButton] is the outlined version of the [PrimaryButton]
/// Used for secondary actions.

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.isLoading = false,
      this.textColor,
      this.textSize,
      this.textWeight});
  final Function()? onTap;
  final String text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textWeight;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width,
        height: context.height * 0.06,
        decoration: BoxDecoration(
          color: AppColors.darkButtonColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: isLoading
              ? Helpers.getProgressLoader()
              : Text(
                  text,
                  style: GoogleFonts.inter(
                    color: textColor ?? AppColors.whiteColor,
                    fontSize: textSize ?? 16,
                    fontWeight: textWeight ?? FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

class OutlinedPrimaryButton extends StatelessWidget {
  const OutlinedPrimaryButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.textColor,
      this.textSize,
      this.textWeight});
  final Function()? onTap;
  final String text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width,
        height: context.height * 0.06,
        decoration: BoxDecoration(
          color: AppColors.lightButtonColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: textColor ?? AppColors.darkButtonColor,
              fontSize: textSize ?? 16,
              fontWeight: textWeight ?? FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
