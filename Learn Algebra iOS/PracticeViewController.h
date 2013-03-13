//
//  PracticeViewController.h
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/26/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomKeyboard.h"
#import "AnsweredQuestionViewController.h"
#define jqMathString @"<link rel=\"stylesheet\" href=\"jqMath/jqmath-0.3.0.css\"><script src=\"jqMath/jquery-1.4.3.min.js\"></script><script src=\"jqMath/jqmath-etc-0.3.0.min.js\"></script>"
@interface PracticeViewController : UIViewController<UITextFieldDelegate>
{
    NSString *lesson;
}
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property NSString *lesson;

@end
