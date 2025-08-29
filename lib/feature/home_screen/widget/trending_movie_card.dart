import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_db/networks/endpoint.dart';
import 'package:movies_db/routes/app_routes.dart';

class TrendingMovieCard extends StatelessWidget {
  final String posterPath;
  final int number;
  final int id;

  const TrendingMovieCard({
    super.key,
    required this.posterPath,
    required this.number,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final String url = '${Endpoints.baseImg}$posterPath';
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () =>
            context.push(AppRoutes.movieDetailsScreen, extra: id.toString()),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 24),
              height: context.height * 0.2,
              width: size.width * 0.38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),

                image: DecorationImage(
                  image: CachedNetworkImageProvider(url),
                  fit: BoxFit.cover,
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: Colors.red),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Center(
                child: BorderedText(
                  strokeColor: Colors.white,
                  child: Text(
                    number.toString(),
                    style: const TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
