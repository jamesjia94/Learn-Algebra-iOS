//
//  QuickNotesViewController.m
//  Learn Algebra iOS
//
//  Created by James Jia on 1/26/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "QuickNotesViewController.h"

@interface QuickNotesViewController ()

@end

@implementation QuickNotesViewController
@synthesize lesson=_lesson;
@synthesize webView=_webView;

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
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:_lesson ofType:@"html" inDirectory:@"quicknotes"]];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
