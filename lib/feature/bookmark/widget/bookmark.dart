import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_db/core/widget/loader.dart';
import 'package:movies_db/feature/bookmark/controller/bookmark_controller.dart';

class Bookmark extends StatelessWidget {
  final int id;
  final double width;
  final double height;
  final double iconSize;
  const Bookmark(
    this.id, {
    super.key,
    this.height = 50,
    this.width = 50,
    this.iconSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarkController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () async {
            Dialogs.loader(context);
            await controller.bookmarkById(id);
            if (context.mounted) context.pop();
          },
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: controller.isBookmarked(id) ? Colors.red : Colors.black,
              border: Border.all(
                color: controller.isBookmarked(id) ? Colors.red : Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              controller.isBookmarked(id)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              color: Colors.white,
              size: iconSize,
            ),
          ),
        );
      },
    );
  }
}
