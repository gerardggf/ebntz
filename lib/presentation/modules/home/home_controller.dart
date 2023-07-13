import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state/home_state.dart';

final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>(
  (ref) => HomeController(
    HomeState(),
  ),
);

class HomeController extends StateNotifier<HomeState> {
  HomeController(super.state);

  void updateSearchBar(bool value) => state = state.copyWith(searchBar: value);

  void updateSearchText(String? text) =>
      state = state.copyWith(searchText: text);
}
