//
//  AboutPageViewController.m
//  Learn Algebra iOS
//
//  Created by James Jia on 1/12/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "AboutPageViewController.h"
#define EXEQUALS_URL @"http://exequals.org/#about"

@interface AboutPageViewController ()

@end

@implementation AboutPageViewController
@synthesize webView = _webView;

/**
Loads the url into the webView.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:EXEQUALS_URL]]];
}

@end
