import 'package:flutter_test/flutter_test.dart';
import 'package:level_channel_web/level_channel_web.dart';
import 'package:level_channel_web/level_channel_web_platform_interface.dart';
import 'package:level_channel_web/level_channel_web_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLevelChannelWebPlatform
    with MockPlatformInterfaceMixin
    implements LevelChannelWebPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LevelChannelWebPlatform initialPlatform = LevelChannelWebPlatform.instance;

  test('$MethodChannelLevelChannelWeb is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLevelChannelWeb>());
  });

  test('getPlatformVersion', () async {
    LevelChannelWeb levelChannelWebPlugin = LevelChannelWeb();
    MockLevelChannelWebPlatform fakePlatform = MockLevelChannelWebPlatform();
    LevelChannelWebPlatform.instance = fakePlatform;

    expect(await levelChannelWebPlugin.getPlatformVersion(), '42');
  });
}
