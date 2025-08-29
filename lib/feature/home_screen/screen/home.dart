import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_db/feature/home_screen/controller/home_screen_controller.dart';
import 'package:movies_db/feature/home_screen/widget/movie_card.dart';
import 'package:movies_db/feature/home_screen/widget/search_result_movie_card.dart';
import 'package:movies_db/feature/home_screen/widget/tmdb_logo.dart';
import 'package:movies_db/feature/home_screen/widget/trending_movie_card.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/models/trending_movies/trending_movie_model/trending_movie_model.dart';
import 'package:movies_db/routes/app_routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget get trendingMovies => SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 18),
    sliver: PagedSliverList<int, TrendingMovieModel>.separated(
      separatorBuilder: (ctx, index) => const SizedBox(height: 8),
      pagingController: HomeScreenController.to.trendingMoviesController,
      builderDelegate: PagedChildBuilderDelegate<TrendingMovieModel>(
        animateTransitions: true,

        noItemsFoundIndicatorBuilder: (ctx) =>
            const Text("No Results", style: TextStyle(color: Colors.white)),
        itemBuilder: (context, TrendingMovieModel item, index) =>
            TrendingMovieCard(
              id: item.id,
              posterPath: item.posterPath ?? '',
              number: index + 1,
            ),
      ),
    ),
  );
  Widget get nowPlayingMovies => SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 18),
    sliver: PagedSliverList<int, MovieModel>.separated(
      separatorBuilder: (ctx, index) => const SizedBox(height: 8),
      pagingController: HomeScreenController.to.nowPlayingMoviesController,
      builderDelegate: PagedChildBuilderDelegate<MovieModel>(
        animateTransitions: true,

        noItemsFoundIndicatorBuilder: (ctx) =>
            const Text("No Results", style: TextStyle(color: Colors.white)),
        itemBuilder: (context, MovieModel item, index) =>
            MovieCard(item: item, index: index),
        // NowPlayingMovieCard(model: item, number: index + 1),
      ),
    ),
  );
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TMDBLogo(),

          actions: [
            IconButton(
              onPressed: () async {
                await context.push(AppRoutes.searchScreen);
                HomeScreenController.to.refreshScreen();
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: GetBuilder<HomeScreenController>(
          initState: (_) {},
          dispose: (state) => HomeScreenController.to.handleDisposal(),
          builder: (HomeScreenController controller) {
            return RefreshIndicator.adaptive(
              onRefresh: () async => controller.refreshScreen(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16, left: 16),
                      child: Text(
                        "Top Trending",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: LimitedBox(
                      maxHeight: context.height * 0.2,
                      child: CustomScrollView(
                        controller: controller.trendingMoviesScroll,
                        scrollDirection: Axis.horizontal,
                        slivers: [trendingMovies],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16, left: 16),
                      child: Text(
                        "Now Playing",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                  nowPlayingMovies,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
