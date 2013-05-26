//
//  AnsweredQuestionViewController.h
//  Learn Algebra iOS
//
//  Created by James Jia on 2/9/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PracticeViewController.h"
#import "ChaptersViewController.h"

/**
 ViewController for displaying the correct answer in Practice. Also handles determining whether an answer is correct and updates the statistics stored in the plist file. TODO: determine whether answer is correct and find alternative solutions (2x+3 and 3+2x are equal).
 */
@interface AnsweredQuestionViewController : UIViewController{
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property int chapter;
@property int lesson;
@property NSString *answerString;
@property NSString *explanationString;
@property NSString *typeString;
@property NSString *textFieldString;

@end
