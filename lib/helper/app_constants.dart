import 'package:flutter/material.dart';
import 'package:movies_db/core/theme/app_theme.dart';
import 'package:movies_db/routes/app_routes.dart';

final class AppConstants {
  AppConstants._();
  static final navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static const dummyNetworkImage =
      'https://images.unsplash.com/photo-1532592333381-a141e3f197c9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1935&q=80';

  static List<Color> blackShader = [
    AppTheme.baseColor,
    AppTheme.baseColor,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  static String get appDomain =>
      'https://sparsh_movies_db.com/$AppRoutes.movieDetailsScreen';
}
