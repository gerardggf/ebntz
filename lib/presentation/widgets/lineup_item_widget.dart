import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:ebntz/presentation/global/utils/date_functions.dart';
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
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        getFormattedPostTimeOfDay(lineupItem.creationDate),
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ),
              if (lineupItem.author == 'prueba') const SizedBox(width: 5),
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
                ),
            ],
          ),
        ),
        Image.network(lineupItem.url),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(lineupItem.description),
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
}
