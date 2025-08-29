import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_db/feature/bookmark/controller/bookmark_controller.dart';
import 'package:movies_db/feature/bookmark/widget/bookmark.dart';
import 'package:movies_db/feature/home_screen/widget/movie_card.dart';
import 'package:movies_db/feature/movie_details/widget/movie_card_shimmer.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarkController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text("Bookmarks"),
            backgroundColor: Colors.black,
          ),
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ).copyWith(bottom: 18),
                sliver: PagedSliverList<int, MovieModel>.separated(
                  separatorBuilder: (ctx, index) => const SizedBox(height: 8),
                  pagingController: controller.bookmarkPaging,
                  builderDelegate: PagedChildBuilderDelegate<MovieModel>(
                    animateTransitions: true,
                    firstPageProgressIndicatorBuilder: (ctx) => SizedBox(
                      height: context.height,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) => MovieCardShimmer(),
                        itemCount: 5,
                      ),
                    ),

                    noItemsFoundIndicatorBuilder: (ctx) => const Center(
                      child: Text(
                        "Your Bookmarked Movies will appear here",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    itemBuilder: (context, MovieModel item, index) => Stack(
                      children: [
                        MovieCard(index: index, item: item),
                        Positioned(
                          right: 8,
                          bottom: 14,
                          child: Bookmark(
                            item.id,
                            height: 32,
                            width: 32,
                            iconSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
