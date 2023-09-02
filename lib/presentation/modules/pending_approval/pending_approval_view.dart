import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/lineup_item_model.dart';
import '../../../domain/repositories/posts_repositories.dart';
import '../../global/const.dart';
import '../../widgets/lineup_item_widget.dart';

final pendingApprovalStreamProvider = StreamProvider<List<LineupItemModel>>(
  (ref) => ref.read(postsRepostoryProvider).suscribeToPosts(isApproved: false),
);

class PendingApprovalView extends ConsumerStatefulWidget {
  const PendingApprovalView({super.key});

  @override
  ConsumerState<PendingApprovalView> createState() =>
      _PendingApprovalViewState();
}

class _PendingApprovalViewState extends ConsumerState<PendingApprovalView> {
  @override
  Widget build(BuildContext context) {
    final pendingApprovalStream = ref.watch(pendingApprovalStreamProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Aprobaciones pendientes',
        ),
        elevation: 0,
      ),
      body: pendingApprovalStream.when(
        data: (data) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      'Pendientes: ${data.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.orange,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(15)
                                      .copyWith(right: 0),
                                  child: const Text(
                                    'Pulsa el check para aprobar la publicación inferior una vez revisada.',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    ref
                                        .read(postsRepostoryProvider)
                                        .updatePostApproval(id: data[index].id);
                                  },
                                  icon: const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        LineupItemWidget(
                          lineupItem: data[index],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (e, stackTrace) => Center(
          child: Text('Error: ${e.toString()}'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
