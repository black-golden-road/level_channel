import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'level_channel_method_channel.dart';

abstract class LevelChannelPlatform extends PlatformInterface {
  /// Constructs a LevelChannelPlatform.
  LevelChannelPlatform() : super(token: _token);

  static final Object _token = Object();

  static LevelChannelPlatform _instance = MethodChannelLevelChannel();

  /// The default instance of [LevelChannelPlatform] to use.
  ///
  /// Defaults to [MethodChannelLevelChannel].
  static LevelChannelPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LevelChannelPlatform] when
  /// they register themselves.
  static set instance(LevelChannelPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
