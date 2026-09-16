import 'dart:developer';
import 'package:flutter/services.dart';

enum ServerEnvironment { dev, production }

class ServerConfig {
  static final ServerConfig _instance = ServerConfig._internal();

  ServerEnvironment _currentEnv = ServerEnvironment.dev;

  factory ServerConfig() {
    return _instance;
  }

  ServerConfig._internal();

  Future<void> init() async {
    final flavor = appFlavor;

    switch (flavor) {
      case 'dev':
        _currentEnv = ServerEnvironment.dev;
        break;
      case 'prod':
        _currentEnv = ServerEnvironment.production;
        break;
      default:
        _currentEnv = ServerEnvironment.dev;
    }

    log(
      'ServerConfig initialized with environment: ${_currentEnv.name} (flavor: $flavor)',
    );
  }

  ServerEnvironment get currentEnv => _currentEnv;

  String get baseUrl {
    switch (_currentEnv) {
      case ServerEnvironment.dev:
        return 'https://dev-api.example.com';
      case ServerEnvironment.production:
        return 'https://api.example.com';
    }
  }
}
