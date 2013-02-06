//
//  PracticeViewController.m
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/26/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "PracticeViewController.h"

@interface PracticeViewController ()

@end

@implementation PracticeViewController
@synthesize lesson=_lesson;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CustomKeyboard *customKeyboard = [[CustomKeyboard alloc] init];
    [customKeyboard setTextField:self.textField];
    self.textField.delegate = self;
    self.textField.inputView=customKeyboard;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) keyboardWillShow:(NSNotification *)notif{
    [self animateTextField: _textField up: YES];
}

-(void) keyboardWillHide:(NSNotification *)notif{
    [self animateTextField:_textField up: NO];
}
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 160;
    const float movementDuration = 0.3f;
    
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])){
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    }
    else{
        self.textField.frame = CGRectOffset(self.textField.frame, 0, movement);}
    
    [UIView commitAnimations];
}
@end
