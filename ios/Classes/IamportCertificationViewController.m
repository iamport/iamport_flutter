#import "IamportCertificationViewController.h"

@implementation IamportCertificationViewController: IamportViewController

- (void)showIframe: (NSString*)userCode data:(NSString*)data triggerCallback:(NSString*)triggerCallback
{
    NSString *initCommand = [NSString stringWithFormat: @"IMP.init('%@');", userCode];
    NSString *requestCommand = [NSString stringWithFormat: @"IMP.certification(%@, %@);", data, triggerCallback];
    
    WKWebView* webView = [self valueForKey:@"webView"];
    
    [webView evaluateJavaScript:initCommand completionHandler:nil];
    [webView evaluateJavaScript:requestCommand completionHandler:nil];
}

@end
