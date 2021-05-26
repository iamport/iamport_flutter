#import "IamportFlutterPlugin.h"

#if __has_include(<iamport_flutter/iamport_flutter-Swift.h>)
#import <iamport_flutter/iamport_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_plugin_example-Swift.h"
#import "iamport_flutter-Swift.h"
#endif

@implementation IamportFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIamportFlutterPlugin registerWithRegistrar:registrar];
}
@end