#import "IamportPaymentViewController.h"

@implementation IamportPaymentViewController: IamportViewController

NSString *const BANKPAY = @"kftc-bankpay";

- (void)showIframe: (NSString*)userCode data:(NSString*)data triggerCallback:(NSString*)triggerCallback
{
    NSString *initCommand = [NSString stringWithFormat: @"IMP.init('%@');", userCode];
    NSString *requestCommand = [NSString stringWithFormat: @"IMP.request_pay(%@, %@);", data, triggerCallback];
    
    WKWebView* webView = [self valueForKey:@"webView"];

    [webView evaluateJavaScript:initCommand completionHandler:nil];
    [webView evaluateJavaScript:requestCommand completionHandler:nil];
}

- (void)openThirdPartyApp:(NSString *)urlString
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *scheme = [url scheme];
    NSString *path = [url path];
    
    if ([scheme hasPrefix:BANKPAY]) {
        [self triggerBankPay:urlString];
    }
    
    NSURL* appUrl = [self getAppUrl:urlString path:path];
    if ([application canOpenURL:appUrl]) {
        [application openURL:appUrl options:@{} completionHandler:nil];
    } else {
        NSURL* marketUrl = [self getMarketUrl:urlString scheme:scheme];
        [application openURL:marketUrl options:@{} completionHandler:nil];
    }
}

- (void)triggerBankPay: (NSString *)urlString
{
    
}

- (NSURL *)getAppUrl: (NSString *)urlString path:(NSString *)path
{
    NSString *appUrlString = urlString;
    if ([urlString hasPrefix:@"itmss"]) {
        appUrlString = [NSString stringWithFormat: @"https://%@", path];
    }
    return [NSURL URLWithString:[appUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
}

- (NSURL *)getMarketUrl: (NSString *)urlString scheme:(NSString *)scheme
{
    NSString *marketUrlString = nil;
    NSArray *schemes = @[
        @"kftc-bankpay",
        @"ispmobile",
        @"hdcardappcardansimclick",
        @"shinhan-sr-ansimclick",
        @"kb-acp",
        @"mpocket.online.ansimclick",
        @"lottesmartpay",
        @"lotteappcard",
        @"cloudpay",
        @"citimobileapp",
        @"payco",
        @"kakaotalk",
        @"lpayapp",
        @"wooripay",
        @"nhallonepayansimclick",
        @"hanawalletmembers",
        @"shinsegaeeasypayment"
    ];
    NSInteger schemeIndex = [schemes indexOfObject:urlString];
    
    switch (schemeIndex) {
        case 0: // 뱅크페이
            marketUrlString = @"https://itunes.apple.com/kr/app/id398456030";
            break;
        case 1: // ISP/페이북
            marketUrlString = @"https://itunes.apple.com/kr/app/id369125087";
            break;
        case 2: // 현대카드 앱카드
            marketUrlString = @"https://itunes.apple.com/kr/app/id702653088";
            break;
        case 3: // 신한 앱카드
            marketUrlString = @"https://itunes.apple.com/app/id572462317";
            break;
        case 4: // KB국민 앱카드
            marketUrlString = @"https://itunes.apple.com/kr/app/id695436326";
            break;
        case 5: // 삼성앱카드
            marketUrlString = @"https://itunes.apple.com/kr/app/id535125356";
            break;
        case 6: // 롯데 모바일결제
            marketUrlString = @"https://itunes.apple.com/kr/app/id668497947";
            break;
        case 7: // 롯데 앱카드
            marketUrlString = @"https://itunes.apple.com/kr/app/id688047200";
            break;
        case 8: // 하나1Q페이(앱카드)
            marketUrlString = @"https://itunes.apple.com/kr/app/id847268987";
            break;
        case 9: // 시티은행 앱카드
            marketUrlString = @"https://itunes.apple.com/kr/app/id1179759666";
            break;
        case 10: // 페이코
            marketUrlString = @"https://itunes.apple.com/kr/app/id924292102";
            break;
        case 11: // 카카오톡
            marketUrlString = @"https://itunes.apple.com/kr/app/id362057947";
            break;
        case 12: // 롯데 L.pay
            marketUrlString = @"https://itunes.apple.com/kr/app/id1036098908";
            break;
        case 13: // 우리페이
            marketUrlString = @"https://itunes.apple.com/kr/app/id1201113419";
            break;
        case 14: // NH농협카드 올원페이(앱카드)
            marketUrlString = @"https://itunes.apple.com/kr/app/id1177889176";
            break;
        case 15: // 하나카드(하나멤버스 월렛)
            marketUrlString = @"https://itunes.apple.com/kr/app/id1038288833";
            break;
        case 16: // 신세계 SSGPAY
            marketUrlString = @"https://itunes.apple.com/app/id666237916";
            break;
        default:
            marketUrlString = urlString;
            break;
    }
    return [NSURL URLWithString:[marketUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
}

@end
