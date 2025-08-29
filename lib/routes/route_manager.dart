import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_db/feature/bookmark/controller/bookmark_controller.dart';
import 'package:movies_db/feature/home_screen/controller/home_screen_controller.dart';
import 'package:movies_db/feature/main_screen/controller/main_screen_controller.dart';
import 'package:movies_db/feature/main_screen/view/main_screen.dart';
import 'package:movies_db/feature/movie_details/controller/movie_detail_view_controller.dart';
import 'package:movies_db/feature/movie_details/view/movie_details_screen.dart';
import 'package:movies_db/feature/search_screen/controller/search_view_controller.dart';
import 'package:movies_db/feature/search_screen/screen/search_screen.dart';
import 'package:movies_db/helper/app_constants.dart';
import 'package:movies_db/routes/app_routes.dart';
import 'package:movies_db/service/logger_service.dart';
import 'package:movies_db/feature/home_screen/screen/home.dart';
import 'package:movies_db/view/splash_screen.dart';

CustomTransitionPage<dynamic> hcCustomTransitionPage(Widget widget) {
  return CustomTransitionPage(
    child: widget,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

CustomTransitionPage buildPageWithSlideTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );
      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}

class AppRouter {
  AppRouter() {
    LoggerService().logInfo('Approuter initialisation...');
  }

  final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routerNeglect: true,
    initialLocation: AppRoutes.splashScreen,
    navigatorKey: AppConstants.navigatorKey,

    redirect: (ctx, state) => _handleRedirect(state.uri.path),
    routes: [
      GoRoute(
        path: AppRoutes.splashScreen,
        pageBuilder: (context, state) =>
            hcCustomTransitionPage(const SplashScreen()),
      ),
      GoRoute(
        path: AppRoutes.mainScreen,
        pageBuilder: (context, state) {
          Get.lazyPut(() => BookmarkController());
          Get.lazyPut(() => MainScreenController());
          Get.lazyPut(() => HomeScreenController());
          return hcCustomTransitionPage(const MainScreen());
        },
      ),

      GoRoute(
        path: AppRoutes.searchScreen,
        pageBuilder: (context, state) {
          Get.put(SearchViewController());
          return buildPageWithSlideTransition(
            context: context,
            state: state,
            child: const SearchScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.movieDetailsScreen,
        pageBuilder: (context, state) {
          final int? id = int.tryParse(
            (state.pathParameters['id']) ?? (state.extra as String?) ?? '',
          );
          throwIf(id == null, "Movie ID can never be null");
          Get.lazyPut(() => MovieDetailViewController(id!));
          return hcCustomTransitionPage(const MovieDetailsScreen());
        },
      ),
    ],
  );

  static String? _handleRedirect(String currentPath) {
    LoggerService().logInfo('[Redirect]: current path $currentPath');
    Get.lazyPut(() => BookmarkController());
    return null;
  }
}
