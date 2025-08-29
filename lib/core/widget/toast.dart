import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_db/helper/app_constants.dart';

import 'package:oktoast/oktoast.dart';

enum SnackType { success, error, warning, info }

extension on SnackType {
  Color get color {
    switch (this) {
      case SnackType.success:
        return Colors.green;
      case SnackType.error:
        return Colors.redAccent;
      case SnackType.warning:
        return Colors.orangeAccent;
      case SnackType.info:
        return Colors.black;
    }
  }
}

void showSnackBar(
  String message, {
  Duration duration = const Duration(seconds: 4),
  Color? backgroundColor,
  double backgroundRadius = 8,
  Color textColor = Colors.white,
  SnackType snackType = SnackType.info,
}) {
  showToast(
    message,
    duration: duration,
    position: ToastPosition.bottom,
    textPadding: const EdgeInsets.all(10),
    backgroundColor: backgroundColor ?? snackType.color,
    radius: backgroundRadius,
    textStyle: AppConstants
        .navigatorKey
        .currentContext!
        .theme
        .textTheme
        .labelMedium!
        .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
  );
}
