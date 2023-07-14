import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LineupItemWidget extends ConsumerWidget {
  const LineupItemWidget({
    super.key,
    required this.lineupItem,
  });

  final LineupItemModel lineupItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                lineupItem.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const Spacer(),
              Text(
                lineupItem.author,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
              if (lineupItem.author == 'prueba') const SizedBox(width: 15),
              if (lineupItem.author == 'prueba')
                PopupMenuButton<PostOptions>(
                  onSelected: (result) {
                    if (result == PostOptions.edit) {
                    } else if (result == PostOptions.delete) {
                      ref.read(postsRepostoryProvider).deletePost(lineupItem);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<PostOptions>>[
                    const PopupMenuItem<PostOptions>(
                      value: PostOptions.edit,
                      child: Text('Editar'),
                    ),
                    const PopupMenuItem<PostOptions>(
                      value: PostOptions.delete,
                      child: Text('Eliminar'),
                    ),
                  ],
                )
            ],
          ),
        ),
        ExtendedImage.network(lineupItem.url),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(lineupItem.description),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            lineupItem.tags.toString(),
          ),
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
