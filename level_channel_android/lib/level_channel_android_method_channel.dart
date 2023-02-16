import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'level_channel_android_platform_interface.dart';

/// An implementation of [LevelChannelAndroidPlatform] that uses method channels.
class MethodChannelLevelChannelAndroid extends LevelChannelAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('level_channel_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
