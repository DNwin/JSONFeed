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

// Split view controller delegate method, need to set bar button
// When split view controller is in portrait mode, need to implement this method so a barbutton appears to show popover for it
- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    // It will not appear at all if there is no title.
    barButtonItem.title = @"Courses";
    
    // Take the bar button item and place on left side of nav item
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

// Remove button when rotated back into landscape mode
- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Double check that it is the correct button
    if (barButtonItem == self.navigationItem.leftBarButtonItem)
    {
        self.navigationItem.leftBarButtonItem = nil;
        
    }
}
@end
