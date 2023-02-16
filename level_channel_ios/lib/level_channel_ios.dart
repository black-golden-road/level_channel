
import 'level_channel_ios_platform_interface.dart';

class LevelChannelIos {
  Future<String?> getPlatformVersion() {
    return LevelChannelIosPlatform.instance.getPlatformVersion();
  }
}
