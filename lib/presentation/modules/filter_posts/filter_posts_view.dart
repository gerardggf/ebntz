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
        padding: const EdgeInsets.all(30),
        children: [
          CustomButton(
            onPressed: () {
              notifier.updateDate(null);
            },
            child: const Text('Restablecer filtros'),
          ),
          const SizedBox(height: 25),
          const Text(
            'Fecha',
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
        ],
      ),
    );
  }
}
