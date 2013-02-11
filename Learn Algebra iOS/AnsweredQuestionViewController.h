//
//  AnsweredQuestionViewController.h
//  Learn Algebra iOS
//
//  Created by XLab Developer on 2/9/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PracticeViewController.h"
#import "ChaptersViewController.h"
@interface AnsweredQuestionViewController : UIViewController
{
    NSString *lesson;
}
@property (weak, nonatomic) IBOutlet UITextView *answerDisplay;
@property (weak, nonatomic) IBOutlet UITextView *explanationDisplay;
@property NSString *lesson;

@end
