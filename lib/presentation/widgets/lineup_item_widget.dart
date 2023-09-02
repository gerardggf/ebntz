import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:ebntz/presentation/global/const.dart';
import 'package:ebntz/presentation/global/controllers/session_controller.dart';
import 'package:ebntz/presentation/global/utils/date_functions.dart';
import 'package:ebntz/presentation/modules/home/home_controller.dart';
import 'package:ebntz/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LineupItemWidget extends ConsumerWidget {
  const LineupItemWidget({
    super.key,
    required this.lineupItem,
  });

  final LineupItemModel lineupItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homeControllerProvider);
    final notifier = ref.watch(homeControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        lineupItem.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (lineupItem.location != '')
                      Text(
                        lineupItem.location,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        getFormattedPostDate(lineupItem.creationDate),
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        getFormattedPostTimeOfDay(lineupItem.creationDate),
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ),
              if (lineupItem.author == ref.watch(sessionControllerProvider)?.id)
                const SizedBox(width: 5),
              if (lineupItem.author ==
                      ref.watch(sessionControllerProvider)?.id ||
                  (ref.watch(sessionControllerProvider)?.isAdmin ?? false))
                _buildPopUpMenuButtonWidget(context, ref),
            ],
          ),
        ),
        CachedNetworkImage(
          imageUrl: lineupItem.url,
          progressIndicatorBuilder: (context, url, progress) {
            return SizedBox(
              height: 300,
              child: Center(
                child: CircularProgressIndicator(
                  value: (progress.downloaded / 100),
                ),
              ),
            );
          },
        ),
        if ((lineupItem.dates..removeWhere((element) => element.isEmpty))
            .isNotEmpty)
          Row(
            children: [
              if (ref.watch(sessionControllerProvider) != null)
                Expanded(
                  child: controller.fetching
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            final sessionController =
                                ref.read(sessionControllerProvider);
                            if (sessionController?.favorites
                                    .contains(lineupItem.id) ??
                                false) {
                              notifier.deleteFromFavorites(lineupItem.id);
                            } else {
                              notifier.addToFavorites(lineupItem.id);
                            }
                          },
                          icon: Icon(
                            ref
                                    .watch(sessionControllerProvider)!
                                    .favorites
                                    .contains(lineupItem.id)
                                ? Icons.bookmark
                                : Icons.bookmark_outline,
                            size: 30,
                          ),
                        ),
                ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(5).copyWith(
                    bottom: 0,
                    left: 0,
                  ),
                  child: Wrap(
                    children: [
                      ...lineupItem.dates.map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Chip(
                            label: Text(
                              dateToString(
                                    DateTime.parse(e),
                                  ) ??
                                  '',
                              style: const TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        if (lineupItem.description.trim().isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              lineupItem.description,
            ),
          ),
        // Padding(
        //   padding: const EdgeInsets.all(10),
        //   child: Text(
        //     lineupItem.tags.toString(),
        //   ),
        // ),
        const Divider(
          thickness: 5,
        ),
      ],
    );
  }

  Widget _buildPopUpMenuButtonWidget(BuildContext context, WidgetRef ref) =>
      PopupMenuButton<PostOptions>(
        icon: Icon(
          Icons.expand_circle_down_outlined,
          color: ref.watch(sessionControllerProvider)?.isAdmin ?? false
              ? Colors.red
              : Colors.black,
        ),
        onSelected: (result) async {
          if (result == PostOptions.edit) {
            context.pushNamed(
              Routes.editPost,
              pathParameters: {"id": lineupItem.id},
            );
          } else if (result == PostOptions.delete) {
            final result = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Eliminar publicación'),
                    content: const Text(
                      '¿Seguro que quieres eliminar esta publicación?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop(true);
                        },
                        child: const Text(
                          'Confirmar',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop(false);
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ) ??
                false;
            if (result) {
              ref.read(postsRepostoryProvider).deletePost(lineupItem);
            }
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<PostOptions>>[
          const PopupMenuItem<PostOptions>(
            value: PostOptions.edit,
            child: Text('Editar publicación'),
          ),
          const PopupMenuItem<PostOptions>(
            value: PostOptions.delete,
            child: Text('Eliminar publicación'),
          ),
        ],
      );
}
