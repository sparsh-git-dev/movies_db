import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_db/feature/home_screen/widget/search_result_movie_card.dart';
import 'package:movies_db/feature/search_screen/controller/search_view_controller.dart';
import 'package:movies_db/feature/search_screen/domain/entity/grid_data.dart';
import 'package:movies_db/feature/search_screen/widget/grid_category_card.dart';
import 'package:movies_db/feature/search_screen/widget/search_field.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  Widget get genres => Padding(
    padding: const EdgeInsets.only(top: 30),
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.9,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: gridValues.length,
      itemBuilder: (context, index) {
        return GridCategoryCard(index: index);
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewController>(
      dispose: (state) => SearchViewController.to.handleDisposal(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: SearchWidget(controller: controller.searchTextController),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () => controller.searchPagingController.refresh(),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: PagedListView<int, MovieModel>(
                  pagingController: controller.searchPagingController,
                  builderDelegate: PagedChildBuilderDelegate<MovieModel>(
                    firstPageProgressIndicatorBuilder: (ctx) =>
                        SizedBox(height: context.height, child: genres),
                    newPageProgressIndicatorBuilder: (ctx) => const Text(
                      "NEW page loading..",
                      style: TextStyle(color: Colors.white),
                    ),
                    noItemsFoundIndicatorBuilder: (context) =>
                        controller.searchTextController.text.isEmpty
                        ? SizedBox(height: context.height, child: genres)
                        : const Text(
                            "No results found",
                            style: TextStyle(color: Colors.white),
                          ),
                    itemBuilder: (context, item, index) => Padding(
                      padding: EdgeInsets.only(
                        bottom: 20,
                        top: index == 0 ? 20 : 0,
                      ),
                      child: SearchResultMovieCard(model: item),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
