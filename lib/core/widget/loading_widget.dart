import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_db/core/assets/assets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.redAccent, BlendMode.modulate),
        child: SizedBox(
          height: 120,
          width: 120,
          child: Lottie.asset(Assets.loaderJosn, repeat: true),
        ),
      ),
    );
  }
}
