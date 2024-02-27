import 'package:acumen_technical_assessment/core/utils/colors.dart';
import 'package:acumen_technical_assessment/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';

class Alerts {
  static void show(
    String content,
    BuildContext context, {
    int duration = 3000,
    Color color = AppColors.redColor,
    bool hasSubText = false,
    bool isError = false,
  }) {
    showOverlayNotification(
      (context) {
        return Material(
          color: AppColors.transparentColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 55),
            child: Material(
              elevation: 8,
              color: AppColors.transparentColor,
              child: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 65,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(7, 0),
                    child: Container(
                      width: double.maxFinite,
                      height: 65,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: color,
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          if (hasSubText)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  content,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: isError
                                        ? AppColors.redColor
                                        : AppColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  context.l10n.tap_to_dismiss,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: isError
                                        ? AppColors.redColor
                                        : AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            )
                          else
                            Flexible(
                              child: Text(
                                content,
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isError
                                      ? AppColors.redColor
                                      : AppColors.primaryColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      duration: Duration(milliseconds: duration),
    );
  }
}
