
import 'level_channel_web_platform_interface.dart';

class LevelChannelWeb {
  Future<String?> getPlatformVersion() {
    return LevelChannelWebPlatform.instance.getPlatformVersion();
  }
}
