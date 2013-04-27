//
//  LessonViewController.h
//  Learn Algebra iOS
//
//  Created by James Jia on 1/15/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 View Controller that handles displaying UITableView that contains all the lessons as well as a UIWebView that displays the contents of that lesson.
 */
@interface LessonViewController : UIViewController
{
    NSString *lesson;
    UIWebView *webView;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) NSString *lesson;
@end
