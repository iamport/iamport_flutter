#import "IamportFlutterPlugin.h"
#import "IamportPaymentViewController.h"
#import "IamportInicisViewController.h"
#import "IamportNiceViewController.h"
#import "IamportCertificationViewController.h"

@implementation IamportFlutterPlugin

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    // openURL이 trigger되면 IamportFlutterPluginOpenURLNotification을 호출한다
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:IamportFlutterPluginOpenURLNotification object:url]];
    return YES;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"iamport_flutter" binaryMessenger:[registrar messenger]];
    
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    IamportFlutterPlugin* instance = [[IamportFlutterPlugin alloc] initWithViewController:viewController registrar:registrar];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    // openURL을 trigger하기 위해 UIApplicationDelegate에 등록한다
    [registrar addApplicationDelegate:instance];
}

- (instancetype)initWithViewController:(UIViewController *)viewController registrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    self = [super init];
    if (self) {
        _registrar = registrar;
        self.viewController = viewController;
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"launch" isEqualToString:call.method]) {
    NSString* type = [call.arguments objectForKey:@"type"];
    NSDictionary* titleOptions = [call.arguments objectForKey:@"titleOptions"];
    NSDictionary* params = [call.arguments objectForKey:@"params"];
    
    IamportViewController *iamportViewController = nil;
    if ([type isEqualToString:@"nice"]) {
        iamportViewController = [[IamportNiceViewController alloc] init];
    } else if ([type isEqualToString:@"inicis"]) {
        iamportViewController = [[IamportInicisViewController alloc] init];
    } else if ([type isEqualToString:@"certification"]) {
        iamportViewController = [[IamportCertificationViewController alloc] init];
    } else {
        iamportViewController = [[IamportPaymentViewController alloc] init];
    }
      
    iamportViewController.type = type;
    iamportViewController.titleOptions = titleOptions;
    iamportViewController.params = params;
    iamportViewController.registrar = _registrar;
    /*
     delegate 메소드에 전달 result 전달
     delegate 메소드에서 result에 접근할 수 없는 점 방지
    */
    iamportViewController.result = result;
    
    NSString *show = [titleOptions valueForKey:@"show"];
    if ([show isEqual:@"true"]) {
        // NavigationController 설정
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:iamportViewController];
        
        NSString *text = [titleOptions valueForKey:@"text"];
        NSString *textColor = [titleOptions valueForKey:@"textColor"];
        NSString *backgroundColor = [titleOptions valueForKey:@"backgroundColor"];
        UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(onClose)];
        UIColor *tintColor = [self colorFromHexString:textColor];
        
        navigationController.navigationBar.topItem.title = text;
        navigationController.navigationBar.translucent = NO;
        navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:tintColor forKey:NSForegroundColorAttributeName];
        navigationController.navigationBar.barTintColor = [self colorFromHexString:backgroundColor];
        navigationController.navigationBar.topItem.rightBarButtonItem = closeButton;
        navigationController.navigationBar.tintColor = tintColor;

        [self.viewController presentViewController:navigationController animated:YES completion:nil];
    } else {
        [self.viewController presentViewController:iamportViewController animated:YES completion:nil];
    }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (void)onClose
{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setDelegate:(id<IamportDelegate>)delegate
{
    _delegate = delegate;
}

- (void)onOver:(NSString*)url result:(FlutterResult)result
{
    // 결제완료 후 DART에 결제 결과 URL 전달
    result(url);
}

@end

NSString* const IamportFlutterPluginOpenURLNotification = @"IamportFlutterPluginOpenURLNotification";
