import 'package:flutter/material.dart';
import 'package:movies_db/core/widget/loading_widget.dart';
import 'package:movies_db/helper/app_constants.dart';

class Dialogs {
  Dialogs._();

  static Future<void> loader([BuildContext? ctx]) {
    return showDialog<void>(
      context: ctx ?? AppConstants.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const PopScope(
          canPop: false,
          child: Center(child: LoadingWidget()),
        );
      },
    );
  }
}
