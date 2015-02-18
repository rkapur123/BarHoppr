//
//  LoginViewController.m
//  ColumbiaBarRatingMain
//
//  Created by Rahul Kapur on 9/20/14.
//  Copyright (c) 2014 Rahul Kapur. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    self.view.backgroundColor = [UIColor colorWithRed:0.894 green:0.157 blue:0.486 alpha:1];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkFieldsComplete {

    if([_nameField.text isEqualToString:@""] || [_uniField.text isEqualToString:@""] || [_barHopprAliasField.text isEqualToString:@""]|| [_passwordField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc ] initWithTitle:@"Oooops" message:@"Fill all items" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else {
        NSLog(@"No error");

        [self registerNewUser];
        
    }
}

-(void) registerNewUser {
    PFUser *newUser = [PFUser user];

    
    newUser.username = _barHopprAliasField.text;
    newUser.email = _uniField.text;
    newUser.password = _passwordField.text;
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error) {
            [self performSegueWithIdentifier:@"login" sender:self];
            
        } else {
            UIAlertView *alertView = [[UIAlertView alloc ] initWithTitle:@"Oooops" message:@"BarHoppr Alias or UNI already in use" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
        }
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registerAction:(id)sender {
    [_nameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_uniField resignFirstResponder];
    [_barHopprAliasField resignFirstResponder];

    [self checkFieldsComplete];
}
@end
