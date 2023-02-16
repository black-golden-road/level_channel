import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'level_channel_ios_method_channel.dart';

abstract class LevelChannelIosPlatform extends PlatformInterface {
  /// Constructs a LevelChannelIosPlatform.
  LevelChannelIosPlatform() : super(token: _token);

  static final Object _token = Object();

  static LevelChannelIosPlatform _instance = MethodChannelLevelChannelIos();

  /// The default instance of [LevelChannelIosPlatform] to use.
  ///
  /// Defaults to [MethodChannelLevelChannelIos].
  static LevelChannelIosPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LevelChannelIosPlatform] when
  /// they register themselves.
  static set instance(LevelChannelIosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
