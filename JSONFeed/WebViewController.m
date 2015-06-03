//
//  WebViewController.m
//  JSONFeed
//
//  Created by Dennis Nguyen on 6/3/15.
//  Copyright (c) 2015 dnwin. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()



@end

@implementation WebViewController

- (void)loadView {
    // Create and set webview
    UIWebView *webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    self.view = webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


// Load request with URL onto view every time URL is set
- (void)setURL:(NSURL *)URL
{
    _URL = URL;
    if (_URL)
    {
        NSURLRequest *req = [NSURLRequest requestWithURL:URL];
                [(UIWebView *)self.view loadRequest:req];
    }
}

@end
