import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetService {
  final connectivity = Connectivity();
  final connectivityStream = StreamController<ConnectivityResult>();

  InternetService() {
    connectivity.onConnectivityChanged.listen((event) {
      connectivityStream.add(event);
    });
  }
}
