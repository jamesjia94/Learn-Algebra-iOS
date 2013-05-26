//
//  PracticeViewController.m
//  Learn Algebra iOS
//
//  Created by James Jia on 1/26/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "PracticeViewController.h"

@interface PracticeViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextView *promptDisplay;
@property  NSString *answerString;
@property  NSString *explanationString;
@property NSString *typeString;

/**
 Implements UITextFieldDelegate method. Resigns first responder of textfield.
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

/**
 Overrides UIWindow method and calls animateTextField.
 */
-(void) keyboardWillShow:(NSNotification *)notif;

/**
 Overrides UIWindow method and calls animateTextField.
 */
-(void) keyboardWillHide:(NSNotification *)notif;

/**
 Helper method that ensures that the keyboard does not cover up the textfield.
 */
- (void) animateTextField: (UITextField*) textField up: (BOOL) up height: (CGFloat) height;

/**
 Removes this from NSNotificationCenter - was used to observe UIKeyboardWillShow/Hide Notification.
 */
- (void) viewWillDisappear:(BOOL)animated;

/**
 Clears the text from the textfield.
 */
- (IBAction)clearText:(id)sender;

/**
 IBAction method that pushes AnswerViewController onto the stack.
 */
- (IBAction)submit:(id)sender;

/**
 Sends the appropriate data/initalizes ivars before segueing.
 */
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

/**
 Displays the appropriate problem from the JSON file using the corresponding modules if necessary to render the math problem. TODO: Graphs using 2D Quartz?
 */
-(void) displayProblem;

/**
 Resizes the textview to fit the content grabbed from JSON file.
 */
-(void) resizeTextView: (UITextView *) textView;

/**
 Resigns textfield as the first responder when the user taps outside of the keyboard.
 */
-(IBAction) dismissTextField:(UIGestureRecognizer *) sender;
@end

@implementation PracticeViewController
@synthesize explanationString=_explanationString;
@synthesize answerString = _answerString;
@synthesize lesson=_lesson;

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
    [self displayProblem];
}

#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark UIWindow methods
-(void) keyboardWillShow:(NSNotification *)notif{
    CGFloat keyboardHeight = [[[notif userInfo] objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    [self animateTextField: _textField up: YES height:keyboardHeight];
}

-(void) keyboardWillHide:(NSNotification *)notif{
    CGFloat keyboardHeight = [[[notif userInfo] objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    [self animateTextField:_textField up: NO height:keyboardHeight];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up height: (CGFloat) height
{
    const float movementDuration = 0.3f;
    
    CGFloat movement = (up ? -height : height);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])){
        self.view.frame = CGRectOffset(self.view.frame, 0, movement/3);
    }
    else{
        self.textField.frame = CGRectOffset(self.textField.frame, 0, movement+50);
        self.promptDisplay.frame = CGRectOffset(self.promptDisplay.frame, 0, movement+50);
    }
    
    [UIView commitAnimations];
}

#pragma mark private methods

-(void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)clearText:(id)sender {
    _textField.text=@"";
}

- (IBAction)submit:(id)sender {
    [self performSegueWithIdentifier:@"answerViewSegue" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"answerViewSegue"]) {
        AnsweredQuestionViewController *vc = [segue destinationViewController];
        [vc setExplanationString:_explanationString];
        [vc setAnswerString:_answerString];
        NSArray* parsedLesson = [_lesson componentsSeparatedByString:@"."];
        [vc setChapter:
         ((NSString *)[parsedLesson objectAtIndex:0]).integerValue];
        [vc setLesson:
         ((NSString *)[parsedLesson objectAtIndex:1]).integerValue];
        [vc setTypeString:_typeString];
        [vc setTextFieldString:self.textField.text];
        vc.navigationItem.title = self.navigationItem.title;
    }
}

-(void) displayProblem{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:self.lesson ofType:@"json" inDirectory:@"Practice"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    NSDictionary *json =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *problemsArray = [json objectForKey:@"problemsArray"];
    NSDictionary *pickedQuestion=[problemsArray objectAtIndex:arc4random_uniform([problemsArray count])];
    self.answerString = [pickedQuestion objectForKey:@"answer"];
    self.explanationString = [pickedQuestion objectForKey:@"explanation"];
    NSString *prompt = [pickedQuestion objectForKey:@"prompt"];
    NSString *question = [pickedQuestion objectForKey:@"question"];
    self.typeString= [pickedQuestion objectForKey:@"type"];
    NSLog(@"answer: %@", self.answerString);
    if (prompt == nil){
        _promptDisplay.text = @"Answer:";
    }
    else{
        _promptDisplay.text=prompt;
    }
    if ([_typeString isEqualToString:JQMATH]){
        [_webView loadHTMLString:[NSString stringWithFormat:@"%@%@",question,JQMATHHEADER] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
    else if ([_typeString isEqualToString:GRAPH]){
        
    }
    else if ([_typeString isEqualToString:MC]){
        
    }
    else if ([_typeString isEqualToString:TEXT]){
        [_webView loadHTMLString:question baseURL:nil];
    }
    else if ([_typeString isEqualToString:MATHJAX]){
        [_webView loadHTMLString:[NSString stringWithFormat:@"%@%@",question, MATHJAXHEADER] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
    [self resizeTextView: _promptDisplay];
}

-(void) resizeTextView: (UITextView *) textView{
    CGRect frame = textView.frame;
    frame.size.height = textView.contentSize.height;
    textView.frame = frame;
}

-(IBAction) dismissTextField:(UIGestureRecognizer *) sender{
    [self.textField resignFirstResponder];
}
@end
