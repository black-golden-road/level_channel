import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'level_channel_platform_interface.dart';

/// An implementation of [LevelChannelPlatform] that uses method channels.
class MethodChannelLevelChannel extends LevelChannelPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('level_channel');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
