import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'level_channel_android_method_channel.dart';

abstract class LevelChannelAndroidPlatform extends PlatformInterface {
  /// Constructs a LevelChannelAndroidPlatform.
  LevelChannelAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static LevelChannelAndroidPlatform _instance = MethodChannelLevelChannelAndroid();

  /// The default instance of [LevelChannelAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelLevelChannelAndroid].
  static LevelChannelAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LevelChannelAndroidPlatform] when
  /// they register themselves.
  static set instance(LevelChannelAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
