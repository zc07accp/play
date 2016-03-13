//
//  XXWebViewController.m
//  玩儿
//
//  Created by 欢欢 on 16/2/27.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXWebViewController.h"
#import "NJKWebViewProgress.h"
@interface XXWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForWardItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


@property(nonatomic,strong)NJKWebViewProgress*progress;
@end

@implementation XXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress=[[NJKWebViewProgress alloc]init];
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress = progress;
        
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    self.progress.webViewProxyDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.webView.delegate=self.progress;

    
}

- (IBAction)refresh:(id)sender
{
    [self.webView reload];
}

- (IBAction)goBack:(id)sender
{
    [self.webView goBack];
    
}
- (IBAction)goForWard:(id)sender
{
    [self.webView goForward];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    self.goBackItem.enabled=webView.canGoBack;
    self.goForWardItem.enabled=webView.canGoForward;
    
    
}

-(void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
