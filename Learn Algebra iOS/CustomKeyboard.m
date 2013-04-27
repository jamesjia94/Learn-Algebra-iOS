//
//  CustomKeyboard.m
//  Learn Algebra iOS
//
//  Created by James Jia on 1/25/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "CustomKeyboard.h"
#define kChar @[ @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"(", @"x", @"y", @"+", @"-", @"*", @"/", @"=", @"^", @"√", @".", @")", @"<", @">", @",", @" ", @" ", @" ", @" ", @" "]

@interface CustomKeyboard()
/**
 Sets the title of each button in self.characterKeys to be its corresponding character defined in kChar array.  Assumes the number of characters and buttons are equal.
 */
-(void)loadCharactersWithArray:(NSArray *)a;

/**
 Sets the _textField ivar to point to the passed in textField.
 */
-(void)setTextField:(id<UITextInput>)textField;

/**
 Returns the textField that _textField ivar is pointing to.
 */
-(id<UITextInput>)textField;

/**
 Removes a character from the current text in _textField ivar.
 */
- (IBAction)deletePressed:(id)sender;

/**
 Updates the _textField ivar.  If button title is "Space", add an empty space. If button title is "Return", resign the textfield as the first responder.
 */
- (IBAction)characterPressed:(id)sender;
@end

@implementation CustomKeyboard
@synthesize textField=_textField;

- (id)init{
	if (self) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomKeyboard" owner:self options:nil];
        self = [nib objectAtIndex:0];
    }
    
    [self loadCharactersWithArray:kChar];
    return self;
}

-(void)loadCharactersWithArray:(NSArray *)a {
	int i = 0;
	for (UIButton *b in self.characterKeys) {
		[b setTitle:[a objectAtIndex:i] forState:UIControlStateNormal];
		i++;
	}
}

-(void)setTextField:(id<UITextInput>)textField {
	
	if ([textField isKindOfClass:[UITextField class]])
        [(UITextView *)textField setInputView:self];
    
    _textField = textField;
}

-(id<UITextInput>)textField{
	return _textField;
}

- (IBAction)deletePressed:(id)sender{
    [[UIDevice currentDevice] playInputClick];
    [self.textField deleteBackward];
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textField];
}

- (IBAction)characterPressed:(id)sender {
    [[UIDevice currentDevice] playInputClick];
	UIButton *button = (UIButton *)sender;
	NSString *character = [NSString stringWithString:button.titleLabel.text];
    if ([character isEqualToString:@"Space"]){
        [self.textField insertText: @" "];
    }
    else if ([character isEqualToString:@"Return"]){
        [(UITextField *) self.textField resignFirstResponder];
    }
    else{
	[self.textField insertText:character];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textField];
}

@end
