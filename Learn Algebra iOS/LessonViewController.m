//
//  LessonViewController.m
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/15/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "LessonViewController.h"

@interface LessonViewController ()

@end

@implementation LessonViewController
@synthesize webView = _webView;
@synthesize lesson = _lesson;

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
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:_lesson ofType:@"html" inDirectory:@"MathJaxHTML"]];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
