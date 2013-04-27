//
//  AboutPageViewController.m
//  Learn Algebra iOS
//
//  Created by James Jia on 1/12/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "AboutPageViewController.h"
#define ALGEBRA_STRING @"<html><body><font size=\"10\"><p>Learn Algebra was written by a group of high school friends who looked at the current market offerrings and decided, \"We can do better than that.\"</p>We're dedicated to creating high-quality content and leveraging the mobile platform to educate as efficiently as possible.<br/><br/>You can get more information at our website: http://exequals.com <br/><br/>Visit often to find the latest news updates, to vote on new features, and to voice any questions or concerns you may have.<br/><br/>Also, please rate our app, or contact us at admin@exequals.com!<br/><br/>Visit our Facebook page <a href=\"http://www.facebook.com/pages/ExEquals/305148979598273\">here</a>!</font><body></html>"

@interface AboutPageViewController ()

@end

@implementation AboutPageViewController
@synthesize webView = _webView;

/**
Loads the HTML string into the webView.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_webView loadHTMLString: ALGEBRA_STRING baseURL:nil];
}

@end
