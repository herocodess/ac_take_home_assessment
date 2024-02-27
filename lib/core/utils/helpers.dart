import 'dart:io';

import 'package:acumen_technical_assessment/core/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helpers {
  static Widget getProgressLoader(
      {double? height, double? width, Color? color}) {
    return SizedBox(
      height: (height ?? 15),
      width: (width ?? 15),
      child: Platform.isAndroid
          ? CircularProgressIndicator(
              strokeWidth: 1.5,
              color: color ?? AppColors.whiteColor,
            )
          : Transform.scale(
              scale: 0.5,
              child: CupertinoActivityIndicator(
                color: color ?? AppColors.whiteColor,
              ),
            ),
    );
  }
}
