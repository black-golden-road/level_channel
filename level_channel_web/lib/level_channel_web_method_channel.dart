import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'level_channel_web_platform_interface.dart';

/// An implementation of [LevelChannelWebPlatform] that uses method channels.
class MethodChannelLevelChannelWeb extends LevelChannelWebPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('level_channel_web');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
