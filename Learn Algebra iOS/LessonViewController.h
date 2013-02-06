//
//  LessonViewController.h
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/15/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LessonViewController : UIViewController
{
    NSString *lesson;
    UIWebView *webView;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) NSString *lesson;
@end
