import 'package:flutter/material.dart';
import 'dart:async';

import 'package:level_channel/level_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _levelChannelPlugin = LevelChannel();

  @override
  void initState() {
    super.initState();

    _levelChannelPlugin.addPostObserver('/flutter/show', (p0) {});

    _levelChannelPlugin.addGetObserver('/flutter/get', (p0) async {
      return {'flutter get Observer': true};
    });

    postMessage();
  }

  @override
  void dispose() {
    _levelChannelPlugin.removePostObserver('/flutter/show');
    _levelChannelPlugin.removeGetObserver('/flutter/get');
    super.dispose();
  }

  Future<void> postMessage() async {
    _levelChannelPlugin.post('/navtive/show',
        {'String': 'hello world', 'bool': true, 'num': 123, 'double': 123.78});

    var result =
        await _levelChannelPlugin.get('/navtive/get', {'name': 'hello'});
    if (result != null) {
      debugPrint(result.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text('Running on: '),
        ),
      ),
    );
  }
}
