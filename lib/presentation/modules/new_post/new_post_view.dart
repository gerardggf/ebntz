import 'package:ebntz/data/services/firebase_firestore_service.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPostView extends ConsumerStatefulWidget {
  const NewPostView({super.key});

  @override
  ConsumerState<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends ConsumerState<NewPostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New post'),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(firebaseFirestoreServiceProvider).createPost(
                    LineupItemModel(
                      id: 'sfdsfweq',
                      author: 'fr8e7g3q',
                      creationDate: '26/7/2023',
                      category: 'kdjsfjkas',
                      tags: ['hdashjd', 'kjasfhj', 'akfshkahkfa'],
                      title: 'afhjjkfwe',
                      description: 'jkasfhsakj',
                      location: 'iusafhjadsa',
                      url:
                          'https://fastly.picsum.photos/id/202/1000/1000.jpg?hmac=06EOZKISNxCoPtI2ikLkm3LkVJ7UaHiPTIXwQ_-1L1U',
                    ),
                  );
            },
            icon: const Icon(Icons.publish),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
