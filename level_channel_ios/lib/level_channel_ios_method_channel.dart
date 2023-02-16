import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'level_channel_ios_platform_interface.dart';

/// An implementation of [LevelChannelIosPlatform] that uses method channels.
class MethodChannelLevelChannelIos extends LevelChannelIosPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('level_channel_ios');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
