#import "IamportViewController.h"

@implementation IamportViewController: UIViewController

- (id)init
{
    if (self = [super init]) {
        // IamportFlutterPluginOpenURLNotification에 대해 onDidReceiveData가 호출되도록 observer를 등록한다
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDidReceiveData:) name:IamportFlutterPluginOpenURLNotification object:nil];
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];

    _isWebViewLoaded = NO;

    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;

    self.view = _webView;
    
    _delegate = [[IamportFlutterPlugin alloc] init];
    [_delegate setDelegate:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* key = [_registrar lookupKeyForAsset:@"packages/iamport_flutter/assets/html/webview_source.html"];
    NSString* htmlFile = [[NSBundle mainBundle] pathForResource:key ofType:nil];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *url = navigationAction.request.URL.absoluteString;
    
    if ([self isOver:url]) { // 결제완료
        // 웹뷰 해제
        [_webView stopLoading];
        [_webView removeFromSuperview];
        _webView.UIDelegate = nil;
        _webView.navigationDelegate = nil;
        
        _webView = nil;
       
        // Notification 해제
        [[NSNotificationCenter defaultCenter] removeObserver:self name:IamportFlutterPluginOpenURLNotification object:nil];
        
        // delegate 메소드 호출
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate onOver:url result:_result];
        
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([self isUrlStartsWithAppScheme:url]) { // 외부 앱 호출
        [self openThirdPartyApp:url];
        
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
        if (_isWebViewLoaded == NO) {
            NSString* userCode = [_params valueForKey:@"userCode"];
            NSString* data = [_params valueForKey:@"data"];
            NSString* triggerCallback = [_params valueForKey:@"triggerCallback"];
            [self showIframe: userCode data:data triggerCallback:triggerCallback];
            
            _isWebViewLoaded = YES;
        }
}

- (void)onDidReceiveData:(NSNotification *)notification
{
    
}

- (void)showIframe: (NSString*)userCode data:(NSString*)data triggerCallback:(NSString*)triggerCallback
{
    
}

- (BOOL)isOver:(NSString *) url
{
    // 웹뷰가 아임포트가 지정한 임의의 m_redirect_url과 같으면 결제 종료(완료 또는 실패)로 판단
    NSString* redirectUrl = [_params valueForKey:@"redirectUrl"];
    return [url hasPrefix:redirectUrl];
}

- (BOOL)isUrlStartsWithAppScheme:(NSString *)url
{
    return ![url hasPrefix:@"http"] && ![url hasPrefix:@"https"] && ![url hasPrefix:@"about:blank"] && ![url hasPrefix:@"file"];
}

- (void)openThirdPartyApp:(NSString *)url
{
    
}

- (NSString*) toJsonString:(NSObject*) object
{
    // NSObject를 json string으로 변환
    NSError *writeError = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *stringData = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return stringData;
}

@end
