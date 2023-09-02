import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:ebntz/presentation/global/const.dart';
import 'package:ebntz/presentation/modules/filter_posts/filter_posts_controller.dart';
import 'package:ebntz/presentation/modules/home/home_controller.dart';
import 'package:ebntz/presentation/routes/routes.dart';
import 'package:ebntz/presentation/widgets/lineup_item_widget.dart';
import 'package:ebntz/presentation/widgets/options_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

final postsStreamProvider = StreamProvider<List<LineupItemModel>>(
  (ref) => ref.read(postsRepostoryProvider).suscribeToPosts(),
);

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(homeControllerProvider);
    final notifier = ref.watch(homeControllerProvider.notifier);
    final postsStream = ref.watch(postsStreamProvider);

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
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {
                  notifier.updateSearchBar(!controller.searchBar);
                },
                icon: const Icon(Icons.search),
              ),
              if (controller.searchText != null)
                Positioned(
                  width: 12,
                  height: 12,
                  left: 5,
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {
                  context.pushNamed(Routes.filterPosts);
                },
                icon: const Icon(Icons.tune),
              ),
              if (ref.watch(filterPostsControllerProvider).date != null)
                Positioned(
                  width: 12,
                  height: 12,
                  left: 5,
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      drawer: const OptionsDrawer(),
      body: Column(
        children: [
          if (controller.searchBar)
            Container(
              color: Colors.grey,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              width: double.infinity,
              height: kToolbarHeight,
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextField(
                        autofocus: true,
                        controller: _searchController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          iconColor: AppColors.primary,
                          border: InputBorder.none,
                          hintText: 'Busca por evento o artista',
                        ),
                        onChanged: (value) {
                          notifier.updateSearchText(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          _searchController.text = '';
                          notifier.updateSearchText(null);
                          notifier.updateSearchBar(false);

                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        icon: Icon(
                          _searchController.text != ''
                              ? Icons.close
                              : Icons.keyboard_arrow_up,
                        ),
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: postsStream.when(
              data: (data) {
                final items = data
                    .where(
                      (e) => _filterText(e) && _filterDate(e),
                    )
                    .toList();
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LineupItemWidget(
                      lineupItem: items[index],
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
          ),
        ],
      ),
    );
  }

  bool _filterText(LineupItemModel e) {
    final controller = ref.watch(homeControllerProvider);
    if (controller.searchText == null) {
      return true;
    }

    final regExp = RegExp(r'[^a-zA-Z0-9áéíóúÁÉÍÓÚñÑ]');
    final filteredTags = e.tags.join().toLowerCase().replaceAll(regExp, '');

    final findByArtist = filteredTags.contains(
      controller.searchText!.toLowerCase().replaceAll(' ', ''),
    );

    return e.title.toLowerCase().contains(
              controller.searchText!.toLowerCase(),
            ) ||
        findByArtist && e.approved;
  }

  bool _filterDate(LineupItemModel e) {
    final postDates = e.dates..removeWhere((element) => element == '');
    final filterController = ref.watch(filterPostsControllerProvider);
    if (filterController.date == null) {
      return true;
    }

    if (postDates.isEmpty) {
      return false;
    }

    return postDates
        .map(
          (e) => DateTime.parse(e),
        )
        .contains(
          filterController.date,
        );
  }
}
