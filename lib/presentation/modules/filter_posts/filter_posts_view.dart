import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/presentation/global/const.dart';
import 'package:ebntz/presentation/global/utils/date_functions.dart';
import 'package:ebntz/presentation/modules/filter_posts/filter_posts_controller.dart';
import 'package:ebntz/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterPostsView extends ConsumerWidget {
  const FilterPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(filterPostsControllerProvider);
    final notifier = ref.watch(filterPostsControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Filtrar publicaciones',
        ),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Ordenar por:',
            style: TextStyle(
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
                          ? AppColors.primary
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
          const SizedBox(height: 30),
          const Text(
            'Filtrar por fecha',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () async {
                  final result = await showDatePicker(
                        context: context,
                        initialDate: controller.date ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      ) ??
                      controller.date;
                  notifier.updateDate(result);
                },
                child: Text(
                  controller.date == null
                      ? 'Añadir fecha'
                      : dateToString(controller.date)!,
                  style: const TextStyle(
                    fontSize: 20,
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
                    color: Colors.blue,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 30),
          CustomButton(
            onPressed: () {
              notifier.clearFilters();
            },
            child: const Text('Restablecer filtros'),
          ),
        ],
      ),
    );
  }

  String _getOrderRoutesText(OrderPostsBy orderBy) {
    switch (orderBy) {
      case OrderPostsBy.creationDate:
        return 'Fecha de creación';
      case OrderPostsBy.firstDate:
        return 'Fecha evento';
      case OrderPostsBy.name:
        return 'Nombre';
      case OrderPostsBy.location:
        return 'Ubicación';
      default:
        return 'Fecha de creación';
    }
  }
}
