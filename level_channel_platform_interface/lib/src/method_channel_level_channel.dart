import 'package:flutter/services.dart';

import '../level_channel_platform_interface.dart';

class MethodChannelLevelChannel extends LevelChannelPlatform {
  final _writerChannel = const BasicMessageChannel(
    "com.flutter.seewo.plugins/level_channel/writer",
    JSONMessageCodec(),
  );

  final _readerChannel = const BasicMessageChannel(
    "com.flutter.seewo.plugins/level_channel/reader",
    JSONMessageCodec(),
  );

  MethodChannelLevelChannel() {
    _readerChannel.setMessageHandler((message) async {
      didRead(message);
      return null;
    });
  }

  @override
  Future<void> send(Map<String, dynamic> message) async {
    _writerChannel.send(message);
  }
}
