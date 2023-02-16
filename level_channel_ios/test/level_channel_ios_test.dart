import 'package:flutter_test/flutter_test.dart';
import 'package:level_channel_ios/level_channel_ios.dart';
import 'package:level_channel_ios/level_channel_ios_platform_interface.dart';
import 'package:level_channel_ios/level_channel_ios_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLevelChannelIosPlatform
    with MockPlatformInterfaceMixin
    implements LevelChannelIosPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LevelChannelIosPlatform initialPlatform = LevelChannelIosPlatform.instance;

  test('$MethodChannelLevelChannelIos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLevelChannelIos>());
  });

  test('getPlatformVersion', () async {
    LevelChannelIos levelChannelIosPlugin = LevelChannelIos();
    MockLevelChannelIosPlatform fakePlatform = MockLevelChannelIosPlatform();
    LevelChannelIosPlatform.instance = fakePlatform;

    expect(await levelChannelIosPlugin.getPlatformVersion(), '42');
  });
}
