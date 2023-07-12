import 'package:ebntz/data/services/firebase_firestore_service.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
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
            onPressed: () {},
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
      body: StreamBuilder<List<LineupItemModel>>(
          stream: posts,
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text('Error'),
              );
            }
            final items = snapshot.data!;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return LineupItemWidget(
                  lineupItem: items[index],
                );
              },
            );
          }),
    );
  }
}

final lineupItems = [
  LineupItemModel(
    id: 'sadsa',
    author: 'asdas',
    creationDate: 'asdas',
    category: "asdas",
    tags: ['asdas', 'asdas', 'asdas'],
    title: 'Festa major Terrassa',
    description:
        'jkasdfhas dfasf uioasduiof asdfioasuiof auiosf asuifoasdguiof asodf asduiofuioasg uias dfoa sdgfgoasdfg oasgo fagosdfg asogd fgas',
    location: 'asdas',
    url: 'asdas',
  ),
  LineupItemModel(
    id: 'fasdgasd',
    author: 'asdas',
    creationDate: 'asdas',
    category: "asdas",
    tags: ['asdas', 'asdas', 'asdas', 'asdass'],
    title: 'bsdfasdfa',
    description:
        'jkasdfhas dfasf uioasduiof asdfioasuiof auiosf asuifoasdguiof asodf asduiofuioasg gosdfg asogd fgas',
    location: 'asdas',
    url: 'asdas',
  ),
  LineupItemModel(
    id: 'gwrtgwr',
    author: 'asdas',
    creationDate: 'asdas',
    category: "asdas",
    tags: ['asdas', 'asdas', 'asdas'],
    title: 'csdgfsg',
    description:
        'jkasdfhas  uidfioas dfoa sdgfgoasdfg oasgo fagosdfg asogd fgas',
    location: 'asdas',
    url: 'asdas',
  ),
  LineupItemModel(
    id: 'sadsa',
    author: 'asdas',
    creationDate: 'asdas',
    category: "asdas",
    tags: ['asdas', 'asdas'],
    title: 'dfdfgwert',
    description:
        'jkasdfhas dfasf uioasduiofsduiofuioasg uidfioas dfoa sdgfgoasdfg oasgo fagosdfg asogd fgas',
    location: 'asdas',
    url: 'asdas',
  ),
];
