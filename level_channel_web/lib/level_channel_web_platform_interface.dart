import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'level_channel_web_method_channel.dart';

abstract class LevelChannelWebPlatform extends PlatformInterface {
  /// Constructs a LevelChannelWebPlatform.
  LevelChannelWebPlatform() : super(token: _token);

  static final Object _token = Object();

  static LevelChannelWebPlatform _instance = MethodChannelLevelChannelWeb();

  /// The default instance of [LevelChannelWebPlatform] to use.
  ///
  /// Defaults to [MethodChannelLevelChannelWeb].
  static LevelChannelWebPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LevelChannelWebPlatform] when
  /// they register themselves.
  static set instance(LevelChannelWebPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
