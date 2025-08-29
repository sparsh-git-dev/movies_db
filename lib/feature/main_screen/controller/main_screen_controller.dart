
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_db/feature/bookmark/controller/bookmark_controller.dart';
import 'package:movies_db/feature/bookmark/view/bookmark_screen.dart';
import 'package:movies_db/feature/home_screen/controller/home_screen_controller.dart';
import 'package:movies_db/feature/home_screen/screen/home.dart';

class MainScreenController extends GetxController {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<Widget> screens = const [Home(), BookmarkScreen()];

  void onItemTapped(int index) {
    if (index == _selectedIndex) return;

    if (index == 1) {
      Get.lazyPut(() => BookmarkController());
      BookmarkController.to.intialiseDependency();
    } else {
      BookmarkController.to.handleDisposal();
      Get.put(HomeScreenController());
    }
    _selectedIndex = index;
    update();
  }
}
