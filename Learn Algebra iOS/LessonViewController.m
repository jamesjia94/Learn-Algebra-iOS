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
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:_lesson ofType:@"html" inDirectory:@"lessons"]];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    NSString *errorDesc = nil;
    NSPropertyListFormat format = nil;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingString:@"Data.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *plist = (NSDictionary *)[NSPropertyListSerialization
                                           propertyListFromData:plistXML
                                           mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                           format:&format
                                           errorDescription:&errorDesc];
    if (!plist) {
        NSLog(@"Error reading plist: %@, format: %lu", errorDesc, format);
    }
    else
    {
        _dataModel = [NSMutableArray arrayWithCapacity:0];
        
        NSMutableArray *allchaps = [plist objectForKey:@"Chapters"];
        for (int i = 1; i  < allchaps.count; i++) {
            NSDictionary *chap = allchaps[i];
            NSMutableArray *lessons = [NSMutableArray arrayWithCapacity:0];
            for(int j = 1; j  <= [chap count] - 1; j++)
            {
                NSString *lesNums = [NSString stringWithFormat:@"%d.%d", i, j];
                [lessons addObject:[lesNums stringByAppendingString:[NSString stringWithFormat:@" %@", [chap objectForKey:lesNums][2]]]];
            }
            [_dataModel addObject:lessons];
        }
    }
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
            if(chap > [_dataModel count]){
                chap = 1;
            }
        }
        
        viewController.navigationItem.title = [NSString stringWithFormat:@"%@", _dataModel[chap - 1][nextNum - 1]];
        [viewController setLesson: [NSString stringWithFormat:@"%d.%d", chap, nextNum]];
    }
    [self viewWillDisappear:true];
}

@end
