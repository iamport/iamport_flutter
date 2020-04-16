#import "IamportInicisViewController.h"

@implementation IamportInicisViewController: IamportPaymentViewController

- (void)onDidReceiveData:(NSNotification *)notification
{
    NSURL *url = notification.object;
    NSString *query = [url query];
    
    NSObject *params = [self valueForKey:@"params"];
    NSString *redirectUrl = [params valueForKey:@"redirectUrl"];
 
    WKWebView* webView = [self valueForKey:@"webView"];
    NSString *requestCommand = [NSString stringWithFormat: @"window.location.href = '%@?%@';", redirectUrl, query];
    
    [webView evaluateJavaScript:requestCommand completionHandler: nil];
}

@end
