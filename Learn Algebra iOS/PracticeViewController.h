//
//  PracticeViewController.h
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/26/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomKeyboard.h"

@interface PracticeViewController : UIViewController<UITextFieldDelegate>
{
    NSString *lesson;
}
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property NSString *lesson;
@end
