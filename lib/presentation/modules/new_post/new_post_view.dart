import 'package:ebntz/data/services/firebase_firestore_service.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/presentation/modules/new_post/new_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

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

  void imagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text(
                'Cámara',
              ),
              onTap: () {
                Navigator.of(context).pop();
                getImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Galería'),
              onTap: () {
                Navigator.of(context).pop();
                getImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getImage(ImageSource imageSource) async {
    final notifier = ref.read(newPostControllerProvider.notifier);
    final pickedFile =
        await ImagePicker().pickImage(source: imageSource, imageQuality: 25);

    if (pickedFile != null) {
      io.File? image;
      image = io.File(pickedFile.path);

      notifier.updateImage(image);
    }
  }
}
