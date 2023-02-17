import Flutter
import UIKit

public class SwiftLevelChannelPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      let manager = LevelChannelManager(messenger: registrar.messenger())
      registrar.publish(manager)
  }
}
