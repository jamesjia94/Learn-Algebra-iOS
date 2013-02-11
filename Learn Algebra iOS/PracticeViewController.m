//
//  PracticeViewController.m
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/26/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "PracticeViewController.h"

@interface PracticeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *problemDisplay;
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
    
    //[self displayProblem];
}

-(void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) keyboardWillShow:(NSNotification *)notif{
    [self animateTextField: _textField up: YES];
    NSLog(@"hi");
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
    NSString *directory = [@"Practice/" stringByAppendingString:(_lesson)];
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:_lesson ofType:@"json" inDirectory:directory]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    NSDictionary *json =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSArray *questionArray = [json objectForKey:@"questionArray"];
    NSDictionary *pickedQuestion=[questionArray objectAtIndex:arc4random_uniform([questionArray count])];
    self.answerString = [pickedQuestion objectForKey:@"answer"];
    self.explanationString = [pickedQuestion objectForKey:@"explanation"];
    NSString *prompt = [pickedQuestion objectForKey:@"prompt"];
    NSString *question = [pickedQuestion objectForKey:@"question"];
    _promptDisplay.text=prompt;
    _problemDisplay.text=question;
    [self resizeTextView: _problemDisplay];
    [self resizeTextView: _promptDisplay];
}

-(void) resizeTextView: (UITextView *) textView{
    CGRect frame = textView.frame;
    frame.size.height = textView.contentSize.height;
    textView.frame = frame;
}

@end
