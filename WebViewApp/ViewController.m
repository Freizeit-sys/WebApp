//
//  ViewController.m
//  WebViewApp
//
//  Created by admin on 2022/10/23.
//

#import "ViewController.h"
#import <Webkit/Webkit.h>

@interface ViewController () <WKScriptMessageHandler>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView* webview = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:webview];
    
    WKUserContentController* userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"hogeCallBack"];
    webview.configuration.userContentController = userContentController;
    
    NSURL* url = [[NSURL alloc] initWithString:@"https://www.example.com"];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    
    // 不揮発から取得し「http_header」に付与
    
    [webview loadRequest:request];
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"didReceiveScriptMessage");
    
    //TODO: Scripi側からメッセージ(↓想定)
    //TODO: webkit.messageHandlers.hogeCallBack.postMessage(cookie);
    if ([message.name isEqualToString:@"hogeCallBack"]) {
        NSLog(@"");
        //TODO: 「document.cookie」から該当の「cookie」を取得し不揮発に保存
    }
}


- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationAction");
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView
decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse
decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationResponse");
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView
didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation");

}

- (NSString*)getCookieForWebView:(WKWebView *)webView {
//    NSString* script = @"document.cookie";
//    [webView evaluateJavaScript:script completionHandler:^(id result, NSError* error) {
//        if (error != nil) {
//            NSLog(@"request error");
//            return @"";
//        }
//        NSLog(@"result: [%@]", result);
//        return [result description];
//    }];
    return @"";
}

@end
