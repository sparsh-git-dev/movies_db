import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_db/core/extensions/extensions.dart';
import 'package:movies_db/helper/app_constants.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/networks/endpoint.dart';
import 'package:movies_db/routes/app_routes.dart';

class SearchResultMovieCard extends StatelessWidget {
  final MovieModel model;

  const SearchResultMovieCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        context.push(AppRoutes.movieDetailsScreen, extra: model.id.toString());
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                  child: CachedNetworkImage(
                    imageUrl:
                        (model.posterPath ?? '').isEmpty &&
                            (model.backdropPath == null ||
                                model.backdropPath!.isEmpty)
                        ? AppConstants.dummyNetworkImage
                        : '${Endpoints.baseImg}${(model.backdropPath ?? model.posterPath)}',
                    fit: BoxFit.scaleDown,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, color: Colors.red),
                  ),
                ),
                16.toWidth(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        DateTime.tryParse(
                              model.releaseDate ?? '',
                            )?.toMMMddyyyy() ??
                            '',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
