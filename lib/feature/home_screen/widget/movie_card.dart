import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:movies_db/helper/app_constants.dart';
import 'package:movies_db/models/movies/movie_model/movie_model.dart';
import 'package:movies_db/networks/endpoint.dart';
import 'package:movies_db/routes/app_routes.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.index, required this.item});
  final int index;
  final MovieModel item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.push(AppRoutes.movieDetailsScreen, extra: item.id.toString()),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.only(top: index == 0 ? 20 : 0, bottom: 20),
          decoration: BoxDecoration(),
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: AppConstants.blackShader,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ).createShader(bounds);
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, color: Colors.red),
                    imageUrl:
                        (item.posterPath ?? '').isEmpty &&
                            (item.backdropPath == null ||
                                item.backdropPath!.isEmpty)
                        ? AppConstants.dummyNetworkImage
                        : '${Endpoints.baseImg}${(item.backdropPath ?? item.posterPath)}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    item.originalTitle ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
