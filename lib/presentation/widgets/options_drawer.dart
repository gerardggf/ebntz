import 'package:ebntz/data/services/firebase_firestore_service.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OptionsDrawer extends ConsumerWidget {
  const OptionsDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 5,
          ),
          child: ListView(
            children: [
              const Text(
                'eBntz',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                title: const Text('Compartir nuevo evento'),
                leading: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onTap: () {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
