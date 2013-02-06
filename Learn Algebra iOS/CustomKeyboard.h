//
//  CustomKeyboard.h
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/25/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomKeyboard : UIView <UIInputViewAudioFeedback>
@property (strong) id<UITextInput> textField;
@property (weak, nonatomic) IBOutlet UIImageView *keyboardBackground;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *characterKeys;
@end
