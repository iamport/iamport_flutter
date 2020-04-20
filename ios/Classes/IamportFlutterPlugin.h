#import <Flutter/Flutter.h>
#import <Flutter/FlutterAppDelegate.h>

@protocol IamportDelegate <NSObject>
@end

@interface IamportFlutterPlugin: NSObject<FlutterPlugin> {
    id <IamportDelegate> _delegate;
}

@property (readonly, strong, nonatomic) NSObject<FlutterPluginRegistrar>* registrar;
@property (nonatomic, retain) UIViewController *viewController;

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result;
- (UIColor *)colorFromHexString:(NSString *)hexString;
- (void)onClose;
- (void)setDelegate:(id<IamportDelegate>)delegate;
- (void)onOver:(NSString*)url result:(FlutterResult)result;

@end

extern NSString* const IamportFlutterPluginOpenURLNotification;
