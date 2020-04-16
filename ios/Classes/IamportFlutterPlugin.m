#import "IamportFlutterPlugin.h"
#import "IamportPaymentViewController.h"
#import "IamportInicisViewController.h"
#import "IamportNiceViewController.h"
#import "IamportCertificationViewController.h"

@implementation IamportFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"iamport_flutter" binaryMessenger:[registrar messenger]];
    
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    IamportFlutterPlugin* instance = [[IamportFlutterPlugin alloc] initWithViewController:viewController registrar:registrar];
    [registrar addMethodCallDelegate:instance channel:channel];
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
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"launch" isEqualToString:call.method]) {
    NSString* type = [call.arguments objectForKey:@"type"];
    NSDictionary* titleData = [call.arguments objectForKey:@"titleData"];
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
    iamportViewController.titleData = titleData;
    iamportViewController.params = params;
    iamportViewController.registrar = _registrar;
    /*
     delegate 메소드에 전달
     delegate 메소드에서 result에 접근할 수 없는 점 방지
     */
      iamportViewController.result = result;
    
    if ([self isNavigationBarHidden:titleData]) {
        [self.viewController presentViewController:iamportViewController animated:YES completion:nil];
    } else {
        // NavigationController 설정
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:iamportViewController];
        
        NSString *name = [titleData valueForKey:@"name"];
        NSString *color = [titleData valueForKey:@"color"];
        UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(onClose)];
        
        navigationController.navigationBar.topItem.title = name;
        navigationController.navigationBar.translucent = NO;
        navigationController.navigationBar.barTintColor = [self colorFromHexString:color];
        navigationController.navigationBar.topItem.rightBarButtonItem = closeButton;

        [self.viewController presentViewController:navigationController animated:YES completion:nil];
    }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (BOOL)isNavigationBarHidden:(NSDictionary *)titleData
{
    return [titleData count] == 0;
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
