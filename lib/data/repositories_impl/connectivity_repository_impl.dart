import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ebntz/data/services/remote/internet_checker.dart';
import 'package:flutter/foundation.dart';

import '../../domain/repositories/connectivity_repository.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  final Connectivity _connectivity;
  final InternetChecker _internetChecker;
  final _controller = StreamController<bool>.broadcast();

  late bool _hasInternet;
  StreamSubscription? _streamSubscription;

  ConnectivityRepositoryImpl(
    this._connectivity,
    this._internetChecker,
  );

  @override
  Future<void> initialize() async {
    Future<bool> hasInternet(ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        return false;
      }
      return _internetChecker.hasInternet();
    }

    _hasInternet = await hasInternet(
      await _connectivity.checkConnectivity(),
    );

    _connectivity.onConnectivityChanged.skip(Platform.isIOS ? 1 : 0).listen(
      (event) async {
        _streamSubscription?.cancel();
        _streamSubscription = hasInternet(event).asStream().listen(
          (value) {
            _hasInternet = value;
            if (kDebugMode) {
              print(value);
            }

            if (_controller.hasListener && !_controller.isClosed) {
              _controller.add(_hasInternet);
            }
          },
        );
      },
    );
  }

  @override
  bool get hasInternet => _hasInternet;

  @override
  Stream<bool> get onInternetChanged => _controller.stream;
}
