import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/generated/translations.g.dart';
import 'package:ebntz/presentation/global/const.dart';
import 'package:ebntz/presentation/global/utils/date_functions.dart';
import 'package:ebntz/presentation/modules/filter_posts/filter_posts_controller.dart';
import 'package:ebntz/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'widgets/filter_item_widget.dart';

part 'utils/utils.dart';

class FilterPostsView extends ConsumerWidget {
  const FilterPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(filterPostsControllerProvider);
    final notifier = ref.watch(filterPostsControllerProvider.notifier);
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          texts.global.filterPosts,
        ),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            '${texts.global.orderBy}:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: OrderPostsBy.values.length,
              padding: const EdgeInsets.only(right: 10),
              itemBuilder: (_, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    notifier.updateOrderBy(OrderPostsBy.values[index]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: controller.orderBy == OrderPostsBy.values[index]
                            ? Colors.white
                            : Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: controller.orderBy == OrderPostsBy.values[index]
                          ? AppColors.secondary
                          : Colors.white,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _getOrderRoutesText(
                              OrderPostsBy.values[index],
                            ),
                            style: TextStyle(
                              color: controller.orderBy ==
                                      OrderPostsBy.values[index]
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
              },
            ),
          ),
          const SizedBox(height: 15),
          const Divider(thickness: 1),
          const SizedBox(height: 15),
          Text(
            texts.global.filterByDate,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FilterItemWidget(
                      onPressed: () {
                        notifier.updateDate(today);
                        context.pop();
                      },
                      text: texts.global.today,
                      date: today),
                  const SizedBox(width: 10),
                  FilterItemWidget(
                    onPressed: () {
                      notifier.updateDate(today.add(
                        const Duration(days: 1),
                      ));
                      context.pop();
                    },
                    text: texts.global.tomorrow,
                    date: today.add(
                      const Duration(days: 1),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilterItemWidget(
                    onPressed: () {
                      notifier.updateDate(today.add(
                        const Duration(days: 2),
                      ));
                      context.pop();
                    },
                    text: texts.global.theDayAfterTomorrow,
                    date: today.add(
                      const Duration(days: 2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      final result = await showDatePicker(
                            context: context,
                            initialDate: controller.date ?? today,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          ) ??
                          controller.date;
                      notifier.updateDate(result);
                    },
                    child: Text(
                      controller.date == null
                          ? texts.global.addDate
                          : dateToString(controller.date)!,
                      style: const TextStyle(
                        fontSize: 20,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                  if (controller.date != null)
                    IconButton(
                      onPressed: () {
                        notifier.updateDate(null);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.secondary,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          CustomButton(
            onPressed: () {
              notifier.clearFilters();
            },
            child: Text(texts.global.resetFilters),
          ),
        ],
      ),
    );
  }
}
