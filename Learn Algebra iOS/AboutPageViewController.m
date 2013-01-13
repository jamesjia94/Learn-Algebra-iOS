//
//  AboutPageViewController.m
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/12/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "AboutPageViewController.h"

@interface AboutPageViewController ()

@end

@implementation AboutPageViewController
@synthesize webView = _webView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_webView loadHTMLString:@"<html><body><font size=\"10\"><p>Learn Algebra was written by a group of high school friends who looked at the current market offerrings and decided, \"We can do better than that.\"</p>We're dedicated to creating high-quality content and leveraging the mobile platform to educate as efficiently as possible.<br/><br/>You can get more information at our website: http://exequals.com <br/><br/>Visit often to find the latest news updates, to vote on new features, and to voice any questions or concerns you may have.<br/><br/>Also, please rate our app, or contact us at admin@exequals.com!<br/><br/>Visit our Facebook page <a href=\"http://www.facebook.com/pages/ExEquals/305148979598273/\">here</a>!</font><body></html>" baseURL:nil];
    _webView.scalesPageToFit=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end