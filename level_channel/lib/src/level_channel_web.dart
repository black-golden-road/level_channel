import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:level_channel_platform_interface/level_channel_platform_interface.dart';

class LevelChannelWebPlugin extends LevelChannelPlatform {
  LevelChannelWebPlugin() {
    html.window.addEventListener('message', (event) {
      if (event is html.MessageEvent) {
        didRead(event.data);
      }
    });
  }

  static void registerWith(Registrar registrar) {
    LevelChannelPlatform.instance = LevelChannelWebPlugin();
  }

  @override
  Future<void> send(Map<String, dynamic> message) async {
    try {
      html.window.parent?.postMessage(message, '*');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
