import 'package:dart_flutter/res/environment/environment.dart';

import 'environment_dev.dart';
import 'environment_local.dart';
import 'environment_prod.dart';
import 'environment_stage.dart';

enum BuildType {
  local, dev, stage, prod;

  bool get isLocal => this == local;
  bool get isDev => this == dev;
  bool get isStage => this == stage;
  bool get isProd => this == prod;

  static BuildType from(String str) {
    switch (str.toLowerCase()) {
      case 'local':
        return BuildType.local;
      case 'dev':
        return BuildType.dev;
      case 'stage':
        return BuildType.stage;
      case 'prod':
        return BuildType.prod;
    }
    throw Error();
  }
}

abstract class AppEnvironment {
  static late BuildType _buildType;
  static late Environment _environment;
  static BuildType get buildType => _buildType;

  static setupEnv(BuildType bt) {
    _buildType = bt;
    switch (bt) {
      case BuildType.local:
        _environment = EnvironmentLocal();
        break;
      case BuildType.dev:
        _environment = EnvironmentDev();
        break;
      case BuildType.stage:
        _environment = EnvironmentStage();
        break;
      case BuildType.prod:
        _environment = EnvironmentProd();
        break;
      default:
        throw Error();
    }
  }

  static Environment get getEnv {
    if (_environment == null) {
      print("빌드 타입이 설정되어있지 않습니다. 개발버전으로로 자동 설정합니다.");
      _environment = EnvironmentDev();
    }
    return _environment;
  }
}
