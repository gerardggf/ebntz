import 'package:ebntz/generated/translations.g.dart';
import 'package:flutter/material.dart';

class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.bookmark_outline,
            size: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              texts.global.youHaveNoSavedPosts,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
