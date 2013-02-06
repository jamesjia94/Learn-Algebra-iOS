//
//  QuickNotesViewController.h
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/26/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickNotesViewController : UIViewController
{
    NSString *lesson;
    UIWebView *webView;
}
@property (nonatomic) NSString *lesson;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
