import 'package:ebntz/domain/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state/filter_posts_state.dart';

final filterPostsControllerProvider =
    StateNotifierProvider<FilterPostsController, FilterPostsState>(
  (ref) => FilterPostsController(
    FilterPostsState(),
  ),
);

class FilterPostsController extends StateNotifier<FilterPostsState> {
  FilterPostsController(super.state);

  void updateDate(DateTime? date) => state = state.copyWith(date: date);

  void updateOrderBy(OrderPostsBy orderBy) =>
      state = state.copyWith(orderBy: orderBy);

  void clearFilters() {
    updateDate(null);
    updateOrderBy(OrderPostsBy.creationDate);
  }
}
