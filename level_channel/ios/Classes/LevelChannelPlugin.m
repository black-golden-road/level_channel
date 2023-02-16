#import "LevelChannelPlugin.h"
#if __has_include(<level_channel/level_channel-Swift.h>)
#import <level_channel/level_channel-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "level_channel-Swift.h"
#endif

@implementation LevelChannelPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLevelChannelPlugin registerWithRegistrar:registrar];
}
@end
