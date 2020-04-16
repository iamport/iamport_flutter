#import "IamportViewController.h"

@interface IamportPaymentViewController: IamportViewController

FOUNDATION_EXPORT NSString *const BANKPAY;

- (void)triggerBankPay: (NSString *)urlString;
- (NSURL *)getAppUrl: (NSString *)urlString path:(NSString *)path;
- (NSURL *)getMarketUrl: (NSString *)urlString scheme:(NSString *)scheme;

@end
