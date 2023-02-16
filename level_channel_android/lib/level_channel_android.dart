
import 'level_channel_android_platform_interface.dart';

class LevelChannelAndroid {
  Future<String?> getPlatformVersion() {
    return LevelChannelAndroidPlatform.instance.getPlatformVersion();
  }
}
