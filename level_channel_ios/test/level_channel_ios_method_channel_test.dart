import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:level_channel_ios/level_channel_ios_method_channel.dart';

void main() {
  MethodChannelLevelChannelIos platform = MethodChannelLevelChannelIos();
  const MethodChannel channel = MethodChannel('level_channel_ios');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
