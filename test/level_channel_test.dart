import 'package:flutter_test/flutter_test.dart';
import 'package:level_channel/level_channel.dart';
import 'package:level_channel/level_channel_platform_interface.dart';
import 'package:level_channel/level_channel_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLevelChannelPlatform
    with MockPlatformInterfaceMixin
    implements LevelChannelPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LevelChannelPlatform initialPlatform = LevelChannelPlatform.instance;

  test('$MethodChannelLevelChannel is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLevelChannel>());
  });

  test('getPlatformVersion', () async {
    LevelChannel levelChannelPlugin = LevelChannel();
    MockLevelChannelPlatform fakePlatform = MockLevelChannelPlatform();
    LevelChannelPlatform.instance = fakePlatform;

    expect(await levelChannelPlugin.getPlatformVersion(), '42');
  });
}
