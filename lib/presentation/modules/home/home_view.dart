import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:ebntz/presentation/global/const.dart';
import 'package:ebntz/presentation/modules/home/home_controller.dart';
import 'package:ebntz/presentation/widgets/lineup_item_widget.dart';
import 'package:ebntz/presentation/widgets/options_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

final postsStreamProvider = StreamProvider<List<LineupItemModel>>(
  (ref) => ref.read(postsRepostoryProvider).getPosts(),
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
        backgroundColor: kPrimaryColor,
        title: const Text(
          'eBntz',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              notifier.updateSearchBar(!controller.searchBar);
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 10),
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(Icons.menu),
            );
          }),
        ],
      ),
      endDrawer: const OptionsDrawer(),
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
                          iconColor: kPrimaryColor,
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
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: postsStream.when(
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
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
