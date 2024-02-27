import 'package:acumen_technical_assessment/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class InputFields extends StatelessWidget {
  const InputFields({
    super.key,
    required this.hint,
    required this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.read = false,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.textInputAction,
    this.inputFormatters,
    this.onTap,
    this.focusedBorder,
    this.maxLength,
    this.fillColor = Colors.transparent,
    this.enabled = true,
    this.filled = false,
    this.maxForceLength,
    this.isSearch = false,
    this.prefixIcon,
    this.autofocus = false,
    this.focusNode,
    this.maxLines = 1,
  });

  final String hint;
  final Widget? suffixIcon;
  final bool read;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final InputBorder? focusedBorder;
  final int? maxLength;
  final bool? enabled;
  final Widget? prefixIcon;
  final Color? fillColor;
  final int maxLines;
  final MaxLengthEnforcement? maxForceLength;
  final bool? filled;
  final bool isSearch, autofocus;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      onTap: onTap,
      maxLines: maxLines,
      autofocus: autofocus,
      autovalidateMode: autovalidateMode,
      maxLengthEnforcement: maxForceLength,
      maxLength: maxLength,
      focusNode: focusNode,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      style: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.whiteColor,
      ),
      readOnly: read,
      enabled: enabled,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.text,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      obscureText: isPassword! == true ? true : false,
      cursorColor: AppColors.whiteColor.withOpacity(0.4),
      decoration: InputDecoration(
        fillColor: fillColor,
        errorStyle: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.red,
        ),
        filled: filled,
        errorMaxLines: 3,
        enabledBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.borderColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(isSearch ? 8 : 5)),
            ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(isSearch ? 8 : 5)),
        ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.borderColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(isSearch ? 8 : 5)),
            ),
        hintText: hint,
        hintStyle: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteColor.withOpacity(0.4),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
