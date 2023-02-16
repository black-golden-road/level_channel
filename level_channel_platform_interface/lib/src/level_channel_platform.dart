import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_level_channel.dart';

const String _kChannelMethodRequest = "request";
const String _kChannelMethodObserver = "observer";
const String _kChannelMethodResponse = "response";

class _ChannelResponse {
  String path;
  String idenfy;
  Completer completer;

  _ChannelResponse(this.path, this.idenfy, this.completer);
}

class _ChannelGetObserver {
  String path;
  Future<Map<String, dynamic>?> Function(Map<String, dynamic>?) callback;

  _ChannelGetObserver(this.path, this.callback);
}

class _ChannelPostObserver {
  String path;
  void Function(Map<String, dynamic>?) callback;

  _ChannelPostObserver(this.path, this.callback);
}

abstract class LevelChannelPlatform extends PlatformInterface {
  LevelChannelPlatform() : super(token: _token);

  static final Object _token = Object();

  static LevelChannelPlatform _instance = MethodChannelLevelChannel();

  static LevelChannelPlatform get instance => _instance;

  static set instance(LevelChannelPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  int _requestIndex = 0;
  final _responses = <String, _ChannelResponse>{};
  final _getObservers = <String, _ChannelGetObserver>{};
  final _postObservers = <String, _ChannelPostObserver>{};

  Future<Map<String, dynamic>?> get(String path, [Map<String, dynamic>? data]) {
    Completer<Map<String, dynamic>?> completer = Completer();
    var idenfy = '${++_requestIndex}';
    var key = path + _kChannelMethodRequest + idenfy;
    var response = _ChannelResponse(path, idenfy, completer);
    _responses[key] = response;
    _send(path, _kChannelMethodRequest, idenfy: idenfy, data: data);
    return completer.future;
  }

  Future<void> post(String path, [Map<String, dynamic>? data]) {
    return _send(path, _kChannelMethodObserver, data: data);
  }

  void addGetObserver(String path,
      Future<Map<String, dynamic>?> Function(Map<String, dynamic>?) callback) {
    _getObservers[path] = _ChannelGetObserver(path, callback);
  }

  void removeGetObserver(String path) {
    _getObservers.remove(path);
  }

  void addPostObserver(
      String path, void Function(Map<String, dynamic>?) callback) {
    _postObservers[path] = _ChannelPostObserver(path, callback);
  }

  void removePostObserver(String path) {
    _postObservers.remove(path);
  }

  Future<void> didRead(Object? message) async {
    try {
      if (message is Map<String, dynamic>) {
        String path = message['path'] as String? ?? 'unknow';
        String method = message['method'] as String? ?? 'unknow';
        String idenfy = message['id'] as String? ?? 'unknow';
        String? data = message['data'] as String?;
        Map<String, dynamic>? result;
        if (data != null && data.isNotEmpty) {
          result = json.decode(data) as Map<String, dynamic>?;
        }
        switch (method) {
          case _kChannelMethodRequest:
            var observer = _getObservers[path];
            if (observer != null) {
              var response = observer.callback(result);
              response.then((value) => _send(path, _kChannelMethodResponse,
                  idenfy: idenfy, data: value));
            }
            break;
          case _kChannelMethodObserver:
            var observer = _postObservers[path];
            if (observer != null) {
              observer.callback(result);
            }
            break;
          case _kChannelMethodResponse:
            var key = path + _kChannelMethodRequest + idenfy;
            var response = _responses.remove(key);
            if (response != null) {
              response.completer.complete(result);
            }
            break;
          default:
            break;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> send(Map<String, dynamic> message) async {
    throw UnimplementedError('send() has not been implemented.');
  }

  Future<void> _send(String path, String method,
      {String? idenfy, Map<String, dynamic>? data}) async {
    try {
      Map<String, dynamic> request = {'path': path, 'method': method};
      if (data != null) {
        request['data'] = json.encode(data);
      }
      if (idenfy != null) {
        request['id'] = idenfy;
      }
      send(request);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
