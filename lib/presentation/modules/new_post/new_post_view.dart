import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/presentation/global/const.dart';
import 'package:ebntz/presentation/global/utils/custom_snack_bar.dart';
import 'package:ebntz/presentation/modules/new_post/new_post_controller.dart';
import 'package:ebntz/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewPostView extends ConsumerStatefulWidget {
  const NewPostView({super.key});

  @override
  ConsumerState<NewPostView> createState() => _NewPostViewState();
}

final GlobalKey<FormState> _formKey = GlobalKey();

class _NewPostViewState extends ConsumerState<NewPostView> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController(),
      _locationController = TextEditingController(),
      _initialDateController = TextEditingController();

  //TODO: añadir selección de fechas del evento

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final controller = ref.watch(newPostControllerProvider);
        _titleController.text = controller.title;
        _descriptionController.text = controller.description;
        _locationController.text = controller.location ?? '';
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(newPostControllerProvider);
    final notifier = ref.watch(newPostControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo evento'),
        elevation: 0,
        backgroundColor: kPrimaryColor,
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
                  if (_titleController.text.length > 25) {
                    return 'El campo no puede tener más de $kMaxCharacters carácteres';
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
              GestureDetector(
                onTap: () async {
                  final result = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        initialDate: DateTime.now(),
                      ) ??
                      DateTime.now();
                  notifier.updateDateTime(result);
                  if (controller.initialDate != null) {
                    _initialDateController.text = DateFormat('dd/MM/yyyy')
                        .format(controller.initialDate!);
                  }
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Fecha inicio',
                    ),
                    controller: _initialDateController,
                  ),
                ),
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
                validator: (value) {
                  if (_titleController.text.length > 25) {
                    return 'El campo no puede tener más de $kMaxCharacters carácteres';
                  }
                  return null;
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
