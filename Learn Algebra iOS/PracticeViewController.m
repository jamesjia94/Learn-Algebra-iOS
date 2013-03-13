//
//  PracticeViewController.m
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/26/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "PracticeViewController.h"

@interface PracticeViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextView *promptDisplay;
@property (weak,nonatomic) NSString *answerString;
@property (weak,nonatomic) NSString *explanationString;

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
    [self displayProblem];
}

-(void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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
- (IBAction)clearText:(id)sender {
    _textField.text=@"";
}
- (IBAction)submit:(id)sender {
    [self performSegueWithIdentifier:@"answerViewSegue" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"answerViewSegue"]) {
        AnsweredQuestionViewController *vc = [segue destinationViewController];
        vc.answerDisplay.text=_answerString;
        vc.explanationDisplay.text=_explanationString;
        [vc setLesson:_lesson];
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
    _promptDisplay.text=prompt;
    [_webView loadHTMLString:[NSString stringWithFormat:@"%@%@",question,jqMathString] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    [self resizeTextView: _promptDisplay];
}

-(void) resizeTextView: (UITextView *) textView{
    CGRect frame = textView.frame;
    frame.size.height = textView.contentSize.height;
    textView.frame = frame;
}

@end
