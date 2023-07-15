import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ebntz/data/repositories_impl/connectivity_repository_impl.dart';
import 'package:ebntz/data/services/remote/internet_checker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityRepositoryProvider = Provider<ConnectivityRepository>(
  (ref) => ConnectivityRepositoryImpl(
    Connectivity(),
    InternetChecker(),
  ),
);

abstract class ConnectivityRepository {
  Future<void> initialize();
  bool get hasInternet;
  Stream<bool> get onInternetChanged;
}
