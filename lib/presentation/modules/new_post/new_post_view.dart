import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/presentation/global/utils/custom_snack_bar.dart';
import 'package:ebntz/presentation/modules/new_post/new_post_controller.dart';
import 'package:ebntz/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class NewPostView extends ConsumerStatefulWidget {
  const NewPostView({super.key});

  @override
  ConsumerState<NewPostView> createState() => _NewPostViewState();
}

final GlobalKey<FormState> _formKey = GlobalKey();

class _NewPostViewState extends ConsumerState<NewPostView> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController(),
      _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(newPostControllerProvider);
    final notifier = ref.watch(newPostControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo evento'),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          if (!controller.fetching)
            IconButton(
              onPressed: () async => _submit(),
              icon: const Icon(Icons.publish),
            ),
          if (controller.fetching)
            const Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: AbsorbPointer(
          absorbing: controller.fetching,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            children: [
              TextFormField(
                controller: _titleController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (_titleController.text == '' ||
                      _titleController.text.isEmpty) {
                    return 'El campo no puede estar vacío';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
                onChanged: (value) {
                  notifier.updateTitle(value);
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Ubicación',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  notifier.updateLocation(value);
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                ),
                maxLength: 500,
                maxLines: null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (_descriptionController.text == '' ||
                      _descriptionController.text.isEmpty) {
                    return 'El campo no puede estar vacío';
                  }
                  return null;
                },
                onChanged: (value) {
                  notifier.updateDescription(value);
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomButton(
                      onPressed: () {
                        imagePickerBottomSheet();
                      },
                      child: Text(
                        controller.image != null
                            ? 'Cambiar imagen'
                            : 'Escoger imagen',
                      ),
                    ),
                  ),
                  if (controller.image != null) const SizedBox(width: 10),
                  if (controller.image != null)
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          notifier.updateImage(null);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              if (controller.image != null)
                Image.file(
                  controller.image!,
                  fit: BoxFit.fitWidth,
                ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void imagePickerBottomSheet() {
    final notifier = ref.watch(newPostControllerProvider.notifier);

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
                notifier.getImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Galería'),
              onTap: () {
                Navigator.of(context).pop();
                notifier.getImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    final controller = ref.read(newPostControllerProvider);
    final notifier = ref.read(newPostControllerProvider.notifier);
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (controller.image == null) {
      showCustomSnackBar(
        context: context,
        text: 'Tienes que seleccionar una imagen',
        color: Colors.orange,
      );
      return;
    }
    final result = await notifier.submit();
    if (result == FirebaseResponse.success) {
      if (mounted) {
        showCustomSnackBar(
          context: context,
          text: 'Nuevo evento enviado con éxito',
        );
        context.pop();
      }
    } else {
      if (mounted) {
        showCustomSnackBar(
          context: context,
          text: 'No se ha podido enviar el evento con éxito',
        );
      }
    }
  }
}