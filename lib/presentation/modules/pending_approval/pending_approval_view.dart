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
          'eBntz',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        elevation: 0,
      ),
      body: pendingApprovalStream.when(
        data: (data) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return LineupItemWidget(
                lineupItem: data[index],
              );
            },
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
