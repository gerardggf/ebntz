import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../const.dart';
import '../filter_posts_controller.dart';

class FilterItemWidget extends ConsumerWidget {
  const FilterItemWidget({
    super.key,
    required this.onPressed,
    required this.text,
    required this.date,
  });

  final VoidCallback onPressed;
  final String text;
  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(filterPostsControllerProvider);
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: controller.date == date ? Colors.white : Colors.black26,
          ),
          borderRadius: BorderRadius.circular(30),
          color: controller.date == date ? AppColors.secondary : Colors.white,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: TextStyle(
                  color: controller.date == date
                      ? Colors.white
                      : AppColors.primary,
                  fontFamily: 'Nexa',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
