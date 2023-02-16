import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:level_channel_web/level_channel_web_method_channel.dart';

void main() {
  MethodChannelLevelChannelWeb platform = MethodChannelLevelChannelWeb();
  const MethodChannel channel = MethodChannel('level_channel_web');

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
