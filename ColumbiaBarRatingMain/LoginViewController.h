//
//  LoginViewController.h
//  ColumbiaBarRatingMain
//
//  Created by Rahul Kapur on 9/20/14.
//  Copyright (c) 2014 Rahul Kapur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *uniField;
@property (strong, nonatomic) IBOutlet UITextField *barHopprAliasField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)registerAction:(id)sender;

@end
