import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebntz/data/services/remote/firebase_firestore_service.dart';
import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/models/user_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:ebntz/generated/translations.g.dart';
import 'package:ebntz/const.dart';
import 'package:ebntz/presentation/global/controllers/session_controller.dart';
import 'package:ebntz/presentation/modules/home/home_controller.dart';
import 'package:ebntz/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../global/utils/functions/date_functions.dart';

class LineupItemWidget extends ConsumerStatefulWidget {
  const LineupItemWidget({
    super.key,
    required this.lineupItem,
  });

  final LineupItemModel lineupItem;

  @override
  ConsumerState<LineupItemWidget> createState() => _LineupItemWidgetState();
}

class _LineupItemWidgetState extends ConsumerState<LineupItemWidget> {
  late Future<UserModel?> _getUserItemFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _getUserItemFuture = ref
            .read(firebaseFirestoreServiceProvider)
            .getUser(widget.lineupItem.author);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        widget.lineupItem.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget.lineupItem.location != '')
                      Text(
                        widget.lineupItem.location,
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
                        getFormattedPostDate(widget.lineupItem.creationDate),
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        getFormattedPostTimeOfDay(
                            widget.lineupItem.creationDate),
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
              const SizedBox(width: 5),
              _buildPopUpMenuButtonWidget(context, ref),
            ],
          ),
        ),
        CachedNetworkImage(
          imageUrl: widget.lineupItem.url,
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
        if ((widget.lineupItem.dates..removeWhere((element) => element.isEmpty))
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
                                    .contains(widget.lineupItem.id) ??
                                false) {
                              notifier
                                  .deleteFromFavorites(widget.lineupItem.id);
                            } else {
                              notifier.addToFavorites(widget.lineupItem.id);
                            }
                          },
                          icon: Icon(
                            ref
                                    .watch(sessionControllerProvider)!
                                    .favorites
                                    .contains(widget.lineupItem.id)
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
                      ...widget.lineupItem.dates.map(
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
        if (widget.lineupItem.description.trim().isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.lineupItem.description,
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
              ? AppColors.secondary
              : Colors.black,
        ),
        onSelected: (result) async {
          if (result == PostOptions.edit) {
            context.pushNamed(
              Routes.editPost,
              pathParameters: {"id": widget.lineupItem.id},
            );
          } else if (result == PostOptions.delete) {
            final result = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(texts.global.deletePost),
                    content: Text(
                      texts.global.areYouSureYouWantToDeleteThisPost,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop(true);
                        },
                        child: Text(
                          texts.global.confirm,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop(false);
                        },
                        child: Text(
                          texts.global.cancel,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ) ??
                false;
            if (result) {
              ref.read(postsRepostoryProvider).deletePost(widget.lineupItem);
            }
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<PostOptions>>[
          PopupMenuItem<PostOptions>(
            enabled: false,
            value: PostOptions.info,
            child: FutureBuilder<UserModel?>(
                future: _getUserItemFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('...');
                  }
                  final username = snapshot.data?.username ?? '';
                  return Text('${texts.global.postedBy} $username');
                }),
          ),
          if (widget.lineupItem.author ==
                  ref.watch(sessionControllerProvider)?.id ||
              (ref.watch(sessionControllerProvider)?.isAdmin ?? false))
            PopupMenuItem<PostOptions>(
              value: PostOptions.edit,
              child: Text(texts.global.editPost),
            ),
          if (widget.lineupItem.author ==
                  ref.watch(sessionControllerProvider)?.id ||
              (ref.watch(sessionControllerProvider)?.isAdmin ?? false))
            PopupMenuItem<PostOptions>(
              value: PostOptions.delete,
              child: Text(texts.global.deletePost),
            ),
        ],
      );
}
