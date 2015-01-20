//
//  LessonViewController.m
//  Learn Algebra iOS
//
//  Created by James Jia on 1/15/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "LessonViewController.h"

@interface LessonViewController ()

/**
 Pushes the appropriate view controller onto the stack.
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end

@implementation LessonViewController
@synthesize webView = _webView;
@synthesize lesson = _lesson;
@synthesize dataModel = _dataModel;

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
    _dataModel = [NSMutableArray arrayWithObjects:
                  [NSMutableArray arrayWithObjects:@"1.1 Building Blocks of Algebra", @"1.2 Solving Equations", @"1.3 Solving Inequalities", @"1.4 Ratio and Proportions", @"1.5 Exponents", @"1.6 Negative Exponents", @"1.7 Scientific Notation", nil],
                  [NSMutableArray arrayWithObjects:@"2.1 Rectangular Coordinate System", @"2.2 Graphing by Plotting Points/Intercept", @"2.3 Graphing using slopes and y-intercepts", @"2.4 Parallel and Perpendicular Lines", @"2.5 Introduction to Functions", nil],
                  [NSMutableArray arrayWithObjects:@"3.1 Systems of Equations by Substitution", @"3.2 Systems of Equations by Elimination", @"3.3 Systems of Equations by Graphing", nil],
                  [NSMutableArray arrayWithObjects:@"4.1 Introduction to Polynomials", @"4.2 Adding and Subtracting Polynomials", @"4.3 Multiplying and Dividing Polynomials", nil],
                  [NSMutableArray arrayWithObjects: @"5.1 Simplifying Rational Expressions", @"5.2 Multiplying and Dividing Rational Expressions", @"5.3 Adding and Subtracting Rational Expressions", @"5.4 Complex Rational Expressions", @"5.5 Solving Rational Equations", nil],
                  [NSMutableArray arrayWithObjects:@"6.1 Intorduction to Factoring", @"6.2 Factoring Trinomials", @"6.3 Factoring Binomials", @"6.4 Solving Equations by Factoring", nil],
                  [NSMutableArray arrayWithObjects: @"7.1 Introduction to Radicals", @"7.2 Simplifying Radical Expressions", @"7.3 Adding and Subtracting Radical Expressions", @"7.4 Multiplying and Dividing Radical Expressions", @"7.5 Rational Exponents", @"7.6 Solving Radical Equations", nil],
                  [NSMutableArray arrayWithObjects: @"8.1 Extracting Square Roots", @"8.2 Completing the Square", @"8.3 Quadratic Formula", @"8.4 Graphing Parabolas", nil],
                  nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue  sender:(id)sender{
    if ([((UIBarButtonItem*)sender).title isEqualToString:@"Practice"]){
        PracticeViewController *viewController = segue.destinationViewController;
        NSString *lessonName = [NSString stringWithFormat:@"%@", _lesson];
        NSArray *les = [lessonName componentsSeparatedByString: @"."];
        NSString *lessonChap = [NSString stringWithFormat:@"%@", les[0]];
        NSString *lessonNum = [NSString stringWithFormat:@"%@", les[1]];
        viewController.navigationItem.title = [NSString stringWithFormat:@"%@", _dataModel[lessonChap.intValue - 1][lessonNum.intValue - 1]];
        [viewController setLesson: [NSString stringWithFormat:@"%.01f", lessonName.floatValue]];
    }
    else if ([((UIBarButtonItem*)sender).title isEqualToString:@"Next Lesson"]){
        LessonViewController *viewController = segue.destinationViewController;
        NSString *lessonName = [NSString stringWithFormat:@"%@", _lesson];
        NSArray *les = [lessonName componentsSeparatedByString: @"."];
        NSString *lessonChap = [NSString stringWithFormat:@"%@", les[0]];
        NSString *lessonNum = [NSString stringWithFormat:@"%@", les[1]];
        
        int chap = lessonChap.intValue;
        int nextNum = lessonNum.intValue + 1;
        if(nextNum > [_dataModel[chap - 1] count]) {
            nextNum = 1;
            chap = chap + 1;
        }
        
        viewController.navigationItem.title = [NSString stringWithFormat:@"%@", _dataModel[chap - 1][nextNum - 1]];
        [viewController setLesson: [NSString stringWithFormat:@"%d.%d", chap, nextNum]];
    }
    [self viewWillDisappear:true];
}

@end
