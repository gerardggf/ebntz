import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/generated/translations.g.dart';
import 'package:ebntz/const.dart';
import 'package:ebntz/presentation/global/utils/custom_snack_bar.dart';
import 'package:ebntz/presentation/modules/new_post/new_post_controller.dart';
import 'package:ebntz/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../global/utils/functions/date_functions.dart';

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
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
        title: Text(texts.global.shareNewEvent),
        elevation: 0,
        backgroundColor: AppColors.primary,
        actions: [
          if (!controller.fetching)
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                onPressed: () async => _submit(),
                child: Text(
                  texts.global.post,
                  style: const TextStyle(
                    color: AppColors.primary,
                  ),
                ),
              ),
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
              const SizedBox(height: 10),
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
                            ? texts.global.changeImage
                            : texts.global.selectImage,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
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
              TextFormField(
                controller: _titleController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (_titleController.text == '' ||
                      _titleController.text.isEmpty) {
                    return texts.global.theFieldCannotbeEmpty;
                  }
                  if (_titleController.text.length > 25) {
                    return texts.global.theFieldCannotHaveMoreThanXCharacters(
                        maxCharacters: kMaxCharacters);
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: texts.global.name,
                ),
                onChanged: (value) {
                  notifier.updateTitle(value);
                },
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () async {
                  _chooseDates();
                },
                icon: const Icon(Icons.add),
                label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    texts.global.addDate,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              if (controller.dates.isNotEmpty) const SizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return ListTile(
                    trailing: IconButton(
                      onPressed: () {
                        final datesCopy = List<DateTime>.from(controller.dates);
                        datesCopy.removeAt(index);
                        notifier.updateDates(datesCopy);
                      },
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                    title: Text(
                      '$index. ${mapWeekday(controller.dates[index].weekday)} ${dateToString(
                            controller.dates[index],
                          ) ?? '?'}',
                    ),
                  );
                },
                itemCount: controller.dates.length,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: texts.global.location,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  notifier.updateLocation(value);
                },
                validator: (value) {
                  if (_titleController.text.length > 25) {
                    return texts.global.theFieldCannotHaveMoreThanXCharacters(
                        maxCharacters: kMaxCharacters);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: texts.global.description,
                ),
                maxLength: 500,
                maxLines: null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  notifier.updateDescription(value);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> imagePickerBottomSheet() async {
    final notifier = ref.watch(newPostControllerProvider.notifier);

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo),
              title: Text(
                texts.global.camera,
              ),
              onTap: () async {
                Navigator.of(context).pop();
                await notifier.getImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: Text(texts.global.gallery),
              onTap: () async {
                Navigator.of(context).pop();
                await notifier.getImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );

    _titleController.text = ref.read(newPostControllerProvider).title;
  }

  Future<void> _chooseDates() async {
    final controller = ref.read(newPostControllerProvider);
    final notifier = ref.read(newPostControllerProvider.notifier);
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDate:
          controller.dates.isEmpty ? DateTime.now() : controller.dates.last,
    );
    final datesCopy = List<DateTime>.from(controller.dates);
    if (datesCopy.contains(date) || date == null) {
      return;
    }
    datesCopy.add(date);
    notifier.updateDates(datesCopy);
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
        text: texts.global.youHaveToSelectAnImage,
        color: AppColors.secondary,
      );
      return;
    }
    final result = await notifier.submit();
    if (result == FirebaseResponse.success) {
      if (mounted) {
        showCustomSnackBar(
          context: context,
          text: texts.global.thePostHasBeenSentForReviewToBeApproved,
        );
        context.pop();
      }
    } else {
      if (mounted) {
        showCustomSnackBar(
          context: context,
          text: texts.global.thePostCouldNotBeSentSuccessfully,
        );
      }
    }
  }
}
