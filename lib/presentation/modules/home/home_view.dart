import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:ebntz/generated/translations.g.dart';
import 'package:ebntz/const.dart';
import 'package:ebntz/presentation/global/controllers/session_controller.dart';
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

final postsStreamProvider =
    StreamProvider.family<List<LineupItemModel>, OrderPostsBy>(
  (ref, orderBy) =>
      ref.read(postsRepostoryProvider).suscribeToPosts(orderBy: orderBy),
);

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(homeControllerProvider);
    final notifier = ref.watch(homeControllerProvider.notifier);
    final filterController = ref.watch(filterPostsControllerProvider);
    final postsStream =
        ref.watch(postsStreamProvider(filterController.orderBy));

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
                  left: 7,
                  top: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: AppColors.secondary,
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
                  left: 7,
                  top: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: AppColors.secondary,
                    ),
                  ),
                ),
            ],
          ),
        ],
        leading: ref.watch(sessionControllerProvider) != null
            ? null
            : IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  context.pushNamed(Routes.profile);
                },
              ),
      ),
      drawer: ref.watch(sessionControllerProvider) == null
          ? null
          : const OptionsDrawer(),
      floatingActionButton: ref.watch(sessionControllerProvider) == null
          ? null
          : FloatingActionButton(
              elevation: 0,
              mini: true,
              onPressed: () {
                context.pushNamed(Routes.newPost);
              },
              backgroundColor: AppColors.primary,
              child: const Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.event,
                      size: 20,
                    ),
                  ),
                  Positioned(
                    left: 1,
                    top: 0,
                    child: Icon(
                      Icons.add_rounded,
                      size: 17,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
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
                        decoration: InputDecoration(
                          icon: const Icon(Icons.search),
                          iconColor: AppColors.primary,
                          border: InputBorder.none,
                          hintText: texts.global.searchByEventOrArtist,
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
          if (filterController.date != null)
            InkWell(
              onTap: () {
                ref
                    .watch(filterPostsControllerProvider.notifier)
                    .clearFilters();
              },
              child: Container(
                color: AppColors.secondary,
                width: double.infinity,
                height: 40,
                child: Center(
                  child: Text(
                    texts.global.resetFilters,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
          if (ref.watch(sessionControllerProvider) == null &&
              controller.showRegisterMessage)
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.orangeAccent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        notifier.updateshowRegisterMessage(false);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(Routes.profile);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          texts.global.infoText1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
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

    return e.title.replaceAll(' ', '').toLowerCase().contains(
              controller.searchText!.replaceAll(' ', '').toLowerCase(),
            ) ||
        findByArtist;
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
