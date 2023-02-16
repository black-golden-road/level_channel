#import "LevelChannelIosPlugin.h"
#if __has_include(<level_channel_ios/level_channel_ios-Swift.h>)
#import <level_channel_ios/level_channel_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "level_channel_ios-Swift.h"
#endif

@implementation LevelChannelIosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLevelChannelIosPlugin registerWithRegistrar:registrar];
}
@end
