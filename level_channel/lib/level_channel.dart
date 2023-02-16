import 'package:level_channel_platform_interface/level_channel_platform_interface.dart';

class LevelChannel {
  factory LevelChannel() {
    _singleton ??= LevelChannel._();
    return _singleton!;
  }

  LevelChannel._();

  static LevelChannel? _singleton;

  static LevelChannelPlatform get _platform {
    return LevelChannelPlatform.instance;
  }

  Future<Map<String, dynamic>?> get(String path, [Map<String, dynamic>? data]) {
    return _platform.get(path, data);
  }

  Future<void> post(String path, [Map<String, dynamic>? data]) {
    return _platform.post(path, data);
  }

  void addGetObserver(String path,
      Future<Map<String, dynamic>?> Function(Map<String, dynamic>?) callback) {
    _platform.addGetObserver(path, callback);
  }

  void removeGetObserver(String path) {
    _platform.removeGetObserver(path);
  }

  void addPostObserver(
      String path, void Function(Map<String, dynamic>?) callback) {
    _platform.addPostObserver(path, callback);
  }

  void removePostObserver(String path) {
    _platform.removePostObserver(path);
  }
}
