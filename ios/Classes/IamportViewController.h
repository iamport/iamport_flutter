#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <Flutter/Flutter.h>
#import <Flutter/FlutterAppDelegate.h>
#import "IamportFlutterPlugin.h"

@interface IamportViewController: UIViewController<WKUIDelegate, WKNavigationDelegate, IamportDelegate>

@property () IamportFlutterPlugin* delegate;
@property (strong, nonatomic) IBOutlet WKWebView *webView;
@property () BOOL isWebViewLoaded;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSDictionary *titleOptions;
@property (strong, nonatomic) NSDictionary *params;
@property (strong, nonatomic) NSObject<FlutterPluginRegistrar>* registrar;
@property (strong, nonatomic) FlutterResult result;

- (id) init;
- (void) onDidReceiveData:(NSNotification *)notification;
- (void) showIframe:(NSString*) userCode data:(NSString*)data triggerCallback:(NSString*)triggerCallback;
- (BOOL) isOver:(NSString*) url;
- (BOOL) isUrlStartsWithAppScheme:(NSString *)url;
- (void) openThirdPartyApp:(NSString *)url;
- (NSString*) toJsonString:(NSObject*) object;

@end
