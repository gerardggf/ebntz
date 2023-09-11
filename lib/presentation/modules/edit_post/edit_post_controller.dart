import 'package:ebntz/domain/enums.dart';
import 'package:ebntz/domain/models/lineup_item_model.dart';
import 'package:ebntz/domain/models/user_model.dart';
import 'package:ebntz/domain/repositories/posts_repositories.dart';
import 'package:ebntz/presentation/global/controllers/session_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state/edit_post_state.dart';

final editPostControllerProvider =
    StateNotifierProvider<EditPostController, EditPostState>(
  (ref) => EditPostController(
    EditPostState(),
    ref.read(postsRepostoryProvider),
    ref.read(sessionControllerProvider),
  ),
);

class EditPostController extends StateNotifier<EditPostState> {
  EditPostController(
    super.state,
    this.postsRepository,
    this.sessionController,
  );

  LineupItemModel? post;
  UserModel? sessionController;

  final PostsRepository postsRepository;

  void updateTitle(String text) => state = state.copyWith(title: text);

  void updateDescription(String text) =>
      state = state.copyWith(description: text);

  void updateLocation(String text) => state = state.copyWith(location: text);

  void updateDates(List<DateTime> date) => state = state.copyWith(dates: date);

  void resetData() {
    updateTitle('');
    updateDates([]);
    updateLocation('');
    updateDescription('');
  }

  void updateFetching(bool value) => state = state.copyWith(fetching: value);

  Future<EditPostState?> loadPostData(String id) async {
    post = await postsRepository.getPost(id);
    if (post == null) return null;
    state = state.copyWith(
      title: post!.title,
      description: post!.description,
      location: post!.location,
      imageUrl: post!.url,
      dates: post!.dates.isEmpty
          ? []
          : post!.dates
              .where((element) => element.isNotEmpty)
              .map(
                (e) => DateTime.parse(e),
              )
              .toList(),
    );
    return state;
  }

  Future<FirebaseResponse> submitUpdate() async {
    updateFetching(true);
    if (post == null) return FirebaseResponse.failure;
    final result = await postsRepository.editPost(
      id: post!.id,
      lineupItemModel: post!.copyWith(
        title: state.title,
        dates: state.dates.isEmpty
            ? []
            : state.dates.map((e) => e.toString()).toList(),
        location: state.location,
        description: state.description,
        approved: (sessionController?.isAdmin ?? false) ? true : false,
      ),
    );
    if (result == FirebaseResponse.success) {
      resetData();
    }
    updateFetching(false);

    return result;
  }
}
