import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_db/core/theme/app_theme.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        fillColor: Colors.white,
        // fillColor: Color(0xffF6F6FA),
        filled: true,
        hintText: 'TV shows, movies and more',
        hintStyle: TextStyle(fontSize: 14, color: AppTheme.bodyTextColor),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(35),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(35),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(35),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(35),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(35),
        ),
        prefixIcon: const Hero(tag: 'search-hero', child: Icon(Icons.search)),
        suffixIcon: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Icon(Icons.close),
        ),
      ),
    );
  }
}
