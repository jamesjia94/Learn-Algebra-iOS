//
//  PracticeViewController.h
//  Learn Algebra iOS
//
//  Created by James Jia on 1/26/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomKeyboard.h"
#import "AnsweredQuestionViewController.h"
#define JQMATHHEADER @"<link rel=\"stylesheet\" href=\"jqMath/jqmath-0.3.0.css\"><script src=\"jqMath/jquery-1.4.3.min.js\"></script><script src=\"jqMath/jqmath-etc-0.3.0.min.js\"></script>"
#define MATHJAXHEADER @"<script type='text/x-mathjax-config'>MathJax.Hub.Config({ messageStyle: \"simple\", showMathMenu: false, jax: ['input/TeX','output/HTML-CSS'], extensions: ['tex2jax.js'], TeX: { extensions: ['AMSmath.js','AMSsymbols.js','noErrors.js','noUndefined.js'] } });</script><script type='text/javascript' src='MathJax/MathJax.js'></script>"
#define TEXT @"text"
#define MC @"mc"
#define GRAPH @"graph"
#define JQMATH @"jqmath"
#define MATHJAX @"mathjax"

/**
 View Controller that handles the display of a problem by parsing the appropriate JSON file and randomly generating a problem from the JSON.
 */

@interface PracticeViewController : UIViewController<UITextFieldDelegate>
{
    NSString *lesson;
}
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property NSString *lesson;
- (IBAction)dismissTextField:(UIGestureRecognizer *)sender;
@end
