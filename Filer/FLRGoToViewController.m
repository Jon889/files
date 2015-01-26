//
//  FLRGoToViewController.m
//  Filer
//
//  Created by Jonathan on 09/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRGoToViewController.h"

@interface FLRGoToViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)cancel:(id)sender;

@end

@implementation FLRGoToViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

- (IBAction)cancel:(id)sender {
    [self.delegate goToViewControllerCancelled];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate goToViewControllerEnteredPath:textField.text];
    
}
@end
