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
    _levelChannelPlugin.post('test', {'key': 'vale'});
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
