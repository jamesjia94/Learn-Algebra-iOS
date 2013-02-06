//
//  CustomKeyboard.m
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/25/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "CustomKeyboard.h"

@implementation CustomKeyboard
@synthesize textField=_textField;
#define kChar @[ @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"(", @"x", @"y", @"+", @"-", @"*", @"/", @"=", @"^", @"√", @".", @")", @"<", @">", @",", @" ", @" ", @" ", @" ", @" "]
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
