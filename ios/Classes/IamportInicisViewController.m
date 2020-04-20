#import "IamportInicisViewController.h"

@implementation IamportInicisViewController: IamportPaymentViewController

- (void)onDidReceiveData:(NSNotification *)notification
{
    NSMutableString *impUid = [NSMutableString string];
    NSMutableString *merchantUid = [NSMutableString string];

    /*
     example://?imp_uid=imp_639444310125%26merchant_uid=mid_1587347437858%26m_redirect_url=http%3A%2F%2Flocalhost%2Fiamport%3Fimp_uid%3Dimp_639444310125%26merchant_uid%3Dmid_1587347437858"를
     decoding한 후, imp_uid와 merchant_uid만 추출해 Flutter로 전달한다
     **/
    NSURL *url = notification.object;
    NSString *decodedQuery = [[url query] stringByRemovingPercentEncoding];
    NSArray *urlComponents = [decodedQuery componentsSeparatedByString:@"&"];
    for (NSString *keyValuePair in urlComponents)
    {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
        NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];

        if ([key isEqualToString:@"imp_uid"]) {
            [impUid appendString:value];
        }
        if ([merchantUid length] == 0 && [key isEqualToString:@"merchant_uid"]) {
            [merchantUid appendString:value];
        }
    }
    
    NSObject *params = [self valueForKey:@"params"];
    NSString *redirectUrl = [params valueForKey:@"redirectUrl"];
 
    WKWebView* webView = [self valueForKey:@"webView"];
    NSString *requestCommand = [NSString stringWithFormat: @"window.location.href = '%@?imp_uid=%@&merchant_uid=%@';", redirectUrl, impUid, merchantUid];
    [webView evaluateJavaScript:requestCommand completionHandler: nil];
}

@end
