import 'package:flutter_test/flutter_test.dart';
import 'package:level_channel_android/level_channel_android.dart';
import 'package:level_channel_android/level_channel_android_platform_interface.dart';
import 'package:level_channel_android/level_channel_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLevelChannelAndroidPlatform
    with MockPlatformInterfaceMixin
    implements LevelChannelAndroidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LevelChannelAndroidPlatform initialPlatform = LevelChannelAndroidPlatform.instance;

  test('$MethodChannelLevelChannelAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLevelChannelAndroid>());
  });

  test('getPlatformVersion', () async {
    LevelChannelAndroid levelChannelAndroidPlugin = LevelChannelAndroid();
    MockLevelChannelAndroidPlatform fakePlatform = MockLevelChannelAndroidPlatform();
    LevelChannelAndroidPlatform.instance = fakePlatform;

    expect(await levelChannelAndroidPlugin.getPlatformVersion(), '42');
  });
}
