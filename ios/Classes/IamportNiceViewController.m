#import "IamportNiceViewController.h"

@implementation IamportNiceViewController: IamportPaymentViewController

- (void)triggerBankPay:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *query = [url query];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *param in [query componentsSeparatedByString:@"&"]) {
      NSArray *elts = [param componentsSeparatedByString:@"="];
      if([elts count] < 2) continue;
      [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    _userKey = [params valueForKey:@"user_key"];
}

- (void)onDidReceiveData:(NSNotification *)notification
{
    NSURL *url = notification.object;
    NSString *query = [url query];

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *param in [query componentsSeparatedByString:@"&"]) {
      NSArray *elts = [param componentsSeparatedByString:@"="];
      if([elts count] < 2) continue;
      [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    NSString *niceTransRedirectionUrl = [[params valueForKey:@"callbackparam1"] stringByRemovingPercentEncoding];
    NSString *bankpaycode = [params valueForKey:@"bankpaycode"];
    NSString *bankpayvalue = [params valueForKey:@"bankpayvalue"];

    NSString *bodyString = [NSString stringWithFormat: @"callbackparam2=%@&bankpay_code=%@&bankpay_value=%@", _userKey, bankpaycode, bankpayvalue];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: [NSURL URLWithString:niceTransRedirectionUrl]];
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: [bodyString dataUsingEncoding: NSUTF8StringEncoding]];
    
    WKWebView* webView = [self valueForKey:@"webView"];
    [webView loadRequest: request];
}

@end
