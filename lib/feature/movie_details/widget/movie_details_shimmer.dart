import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailsShimmer extends StatelessWidget {
  const MovieDetailsShimmer({super.key});

  static const _base = Color(0xFF2A2A2A);
  static const _highlight = Color(0xFF3A3A3A);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverAppBar placeholder (image area)
        SliverAppBar(
          automaticallyImplyLeading: true,
          leading: const _CircleBox(size: 24),
          expandedHeight: MediaQuery.of(context).size.height * 0.4,
          pinned: false,
          backgroundColor: Colors.black,
          flexibleSpace: FlexibleSpaceBar(
            background: Shimmer.fromColors(
              baseColor: _base,
              highlightColor: _highlight,
              child: Container(color: _base),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 27),
            child: Shimmer.fromColors(
              baseColor: _base,
              highlightColor: _highlight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title line
                  _RectBox(height: 28, width: 200, radius: 6),
                  const SizedBox(height: 12),

                  // Genres chip row (3–4 chips)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _ChipBox(width: 70),
                      _ChipBox(width: 56),
                      _ChipBox(width: 92),
                      _ChipBox(width: 64),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: _DividerBox(),
                  ),

                  // Overview paragraph (4–6 lines)
                  _RectBox(height: 12, width: double.infinity),
                  const SizedBox(height: 8),
                  _RectBox(height: 12, width: double.infinity),
                  const SizedBox(height: 8),
                  _RectBox(height: 12, width: double.infinity),
                  const SizedBox(height: 8),
                  _RectBox(
                    height: 12,
                    width:
                        MediaQueryData.fromWindow(
                          WidgetsBinding.instance.window,
                        ).size.width *
                        0.7,
                  ),
                  const SizedBox(height: 16),

                  // Another block to feel like a longer overview
                  _RectBox(height: 12, width: double.infinity),
                  const SizedBox(height: 8),
                  _RectBox(height: 12, width: double.infinity),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Simple rectangular box
class _RectBox extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const _RectBox({required this.height, required this.width, this.radius = 8});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: MovieDetailsShimmer._base,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

/// Circle placeholder (for back button area)
class _CircleBox extends StatelessWidget {
  final double size;
  const _CircleBox({required this.size});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MovieDetailsShimmer._base,
      highlightColor: MovieDetailsShimmer._highlight,
      child: Center(
        child: Container(
          height: size,
          width: size,
          decoration: const BoxDecoration(
            color: MovieDetailsShimmer._base,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

/// Chip-like pill
class _ChipBox extends StatelessWidget {
  final double width;
  const _ChipBox({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      width: width,
      decoration: BoxDecoration(
        color: MovieDetailsShimmer._base,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _DividerBox extends StatelessWidget {
  const _DividerBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      color: MovieDetailsShimmer._base,
    );
  }
}
