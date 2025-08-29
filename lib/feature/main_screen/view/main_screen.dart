import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_db/feature/main_screen/controller/main_screen_controller.dart';
import 'package:movies_db/helper/app_constants.dart';
import 'package:movies_db/routes/app_routes.dart';
import 'package:movies_db/service/logger_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    final appLinks = AppLinks();

    int id = -1;
    appLinks.uriLinkStream.listen((uri) {
      LoggerService().logWarning("URI PATH----> $uri");
      Uri.parse(uri.toString());
      id = int.tryParse(uri.queryParameters['id'] ?? '') ?? -1;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        BuildContext ctx = AppConstants.navigatorKey.currentContext!;
        if (id != -1 && ctx.mounted) {
          String path = GoRouter.of(ctx).state.path ?? '';
          if (path.contains(AppRoutes.movieDetailsScreen)) {
            ctx.pop();
          }
          ctx.push(AppRoutes.movieDetailsScreen, extra: id.toString());
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainScreenController>(
      builder: (controller) {
        return Scaffold(
          body: controller.screens[controller.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex,
            onTap: controller.onItemTapped,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: "Bookmarks",
              ),
            ],
          ),
        );
      },
    );
  }
}
