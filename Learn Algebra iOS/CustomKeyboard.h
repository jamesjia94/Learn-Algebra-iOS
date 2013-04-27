//
//  CustomKeyboard.h
//  Learn Algebra iOS
//
//  Created by James Jia on 1/25/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Custom keyboard that pops up when the user is answering a math question in Practice.
 */
@interface CustomKeyboard : UIView <UIInputViewAudioFeedback>
@property (strong) id<UITextInput> textField;
@property (weak, nonatomic) IBOutlet UIImageView *keyboardBackground;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *characterKeys;
@end
