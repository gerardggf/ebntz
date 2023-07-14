import 'package:ebntz/my_app.dart';
import 'package:ebntz/presentation/modules/new_post/new_post_view.dart';
import 'package:ebntz/presentation/modules/profile/profile_view.dart';
import 'package:ebntz/presentation/offline_view.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../modules/home/home_view.dart';
import 'routes.dart';

mixin RouterMixin on State<MyApp> {
  final router = GoRouter(
    routes: [
      GoRoute(
        name: Routes.home,
        path: '/',
        builder: (_, __) => const HomeView(),
      ),
      GoRoute(
        name: Routes.profile,
        path: '/profile',
        builder: (_, __) => const ProfileView(),
      ),
      GoRoute(
        name: Routes.offline,
        path: '/offline',
        builder: (_, __) => const OfflineView(),
      ),
      GoRoute(
        name: Routes.newPost,
        path: '/new-post',
        builder: (_, __) => const NewPostView(),
      ),
    ],
  );
}
