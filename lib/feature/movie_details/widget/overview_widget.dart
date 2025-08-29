import 'package:flutter/material.dart';
import 'package:movies_db/core/theme/app_theme.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key, required this.overview});
  final String overview;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Overview', style: AppTheme.title),
        const SizedBox(height: 16),
        Text(overview, style: const TextStyle(color: AppTheme.bodyTextColor)),
      ],
    );
  }
}
