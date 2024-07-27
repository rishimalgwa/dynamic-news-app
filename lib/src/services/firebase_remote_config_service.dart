import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:pingo_assignment_app/src/core/constants/firebase_remote_config_keys.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService() : _remoteConfig = FirebaseRemoteConfig.instance;

  final FirebaseRemoteConfig _remoteConfig;

  String get countryCode =>
      _remoteConfig.getString(FirebaseRemoteConfigKeys.countryCode);

  Future<void> initialize() async {
    await _setConfigSettings();
    await _setDefaults();
    await fetchAndActivate();
  }

  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );
  Future<void> _setDefaults() async => _remoteConfig.setDefaults(
        const {
          FirebaseRemoteConfigKeys.countryCode: 'US',
        },
      );

  Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();

    if (updated) {
      log('The config has been updated.');
    } else {
      log('The config is not updated..');
    }
  }
}
