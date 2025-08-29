import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_db/core/extensions/extensions.dart';
import 'package:movies_db/core/theme/app_theme.dart';
import 'package:movies_db/feature/bookmark/widget/bookmark.dart';
import 'package:movies_db/feature/movie_details/controller/movie_detail_view_controller.dart';
import 'package:movies_db/feature/movie_details/widget/genre_widget.dart';
import 'package:movies_db/feature/movie_details/widget/movie_details_shimmer.dart';
import 'package:movies_db/feature/movie_details/widget/no_internet_connection.dart';
import 'package:movies_db/feature/movie_details/widget/overview_widget.dart';
import 'package:movies_db/helper/app_constants.dart';
import 'package:movies_db/models/movies/movie_details_model/movie_details_model.dart';
import 'package:movies_db/networks/endpoint.dart';
import 'package:share_plus/share_plus.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.black,
      body: GetBuilder<MovieDetailViewController>(
        dispose: (state) => state.controller?.handleDisposal(),
        builder: (controller) {
          if (controller.isLoading) return MovieDetailsShimmer();
          if (controller.movieDetailViewModel == null) {
            return NoConnectionScreen(onRetry: () => controller.retry());
          }
          MovieDetailsModel model = controller.movieDetailViewModel!;
          final shareLink =
              "${AppConstants.appDomain}?id=${model.id.toString()}";

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: true,
                leading: GestureDetector(
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                expandedHeight: context.height * 0.4,
                backgroundColor: AppTheme.baseColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: AppConstants.blackShader,
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ).createShader(bounds),
                        child: CachedNetworkImage(
                          imageUrl:
                              (model.posterPath ?? '').isEmpty &&
                                  (model.backdropPath == null ||
                                      model.backdropPath!.isEmpty)
                              ? AppConstants.dummyNetworkImage
                              : '${Endpoints.baseImg}${(model.backdropPath ?? model.posterPath)}',
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error, color: Colors.red),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Share.share(
                                        "Check out this movie: $shareLink",
                                        subject: "Movie Recommendation 🎬",
                                      );
                                    },
                                    icon: Icon(Icons.share_sharp, size: 32),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Bookmark(model.id),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 27,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title ?? '',
                          style: TextStyle(fontSize: 26, color: Colors.grey),
                        ),
                        12.toHeight(),
                        if (model.genres.isNotEmpty)
                          GenreWidget(genres: model.genres),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Divider(
                            color: AppTheme.greyColorLight.withOpacity(0.5),
                          ),
                        ),

                        if ((model.overview ?? '').isNotEmpty)
                          OverviewWidget(overview: model.overview!),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
