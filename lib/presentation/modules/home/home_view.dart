import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
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

class _HomeViewState extends ConsumerState<HomeView> {
  Stream<List<LineupItemModel>>? posts;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _init();
      },
    );
  }

  void _init() {
    posts = ref.read(postsRepostoryProvider).getPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(homeControllerProvider);
    final notifier = ref.watch(homeControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                          iconColor: Colors.black,
                          border: InputBorder.none,
                          hintText: 'Buscar...',
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
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: StreamBuilder<List<LineupItemModel>>(
              stream: posts,
              builder: (BuildContext context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('Error'),
                  );
                }
                final items = snapshot.data!.where(
                  (e) {
                    if (controller.searchText == null) {
                      return true;
                    }
                    return e.title.toLowerCase().contains(
                          controller.searchText!.toLowerCase(),
                        );
                  },
                ).toList();
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
            ),
          ),
        ],
      ),
    );
  }
}
