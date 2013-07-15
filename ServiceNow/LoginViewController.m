//
//  LoginViewController.m
//  ServiceNow
//
//  Created by Developer on 6/11/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "LoginViewController.h"
#import "Reachability.h"

@implementation LoginViewController

#define USERFIELD_TAG 1
#define PASSFIELD_TAG 2

@synthesize usernameTextField, passwordTextField, loginButton, spinner;
@synthesize reach;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	// Do any additional setup after view appears.
    
    reach = [Reachability reachabilityWithHostname:@"www.bing.com"];
    [reach startNotifier];
    
    // Check if login information is stored.
    NSString* username = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    NSString* password = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    //NSLog(@"%@", username ? [@"Username: " stringByAppendingString: username] : @"No Username");
    //NSLog(@"%@", password ? [@"Password: " stringByAppendingString: password] : @"No Password");
    
    // If: credentials are stored
    if (username && password) {
        // Then: imput them into fields
        usernameTextField.text = username;
        passwordTextField.text = password;
    }

    
    //[self autoLogin];
}

/*- (void)autoLogin
{
    NSString* username = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    NSString* password = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    
    NSLog(@"%@", username ? [@"Username: " stringByAppendingString: username] : @"No Username");
    NSLog(@"%@", password ? [@"Password: " stringByAppendingString: password] : @"No Password");
    
    // If: credentials are stored
    if (username && password) {
        // Then: assume valid
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
        
        // Then: load them and check if true
        //if([self confirmLoginUsername:username password:password]) {
        //    [self performSegueWithIdentifier:@"loginSegue" sender:self];
        //}
    }
}*/

- (IBAction)attemptlogin:(id)sender
{
    if(reach.isReachable)
    {
        if([self confirmLoginUsername: usernameTextField.text password: passwordTextField.text]) {
            // Store the passwords
            [[NSUserDefaults standardUserDefaults] setObject:usernameTextField.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:passwordTextField.text forKey:@"password"];
            
            NSString* msg = @"Credentials stored - username:";
            msg = [msg stringByAppendingString:[[NSUserDefaults standardUserDefaults] valueForKey:@"username"]];
            msg = [msg stringByAppendingString: @" password:"];
            msg = [msg stringByAppendingString:[[NSUserDefaults standardUserDefaults] valueForKey:@"password"]];
            NSLog(@"%@",msg);
            
            // Stops and removes it.
            [reach stopNotifier];
            reach = Nil;
            
            [self performSegueWithIdentifier:@"loginSegue" sender:self];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Not Found" message:@"No internet connection found, please connect and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (BOOL)confirmLoginUsername:(NSString*)username password:(NSString*)password
{
    BOOL correctLogin = NO;
    
    [self.spinner startAnimating];
    // check if correct via internet
    if ([username isEqualToString:@"admin"] && [password isEqualToString:@"pass"])
    {
        // show the login screen
        correctLogin = YES;
    }
    
    [self.spinner stopAnimating];
    return correctLogin;
}

// Keyboard disappears if user touches screen - http://mobile.tutsplus.com/tutorials/iphone/ios-sdk-uitextfield-uitextfielddelegate/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

// Dictates how a field behaves when the return button is clicked - http://mobile.tutsplus.com/tutorials/iphone/ios-sdk-uitextfield-uitextfielddelegate/
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == USERFIELD_TAG) {
        NSLog(@"Should switch to passwordTextField");
        [passwordTextField becomeFirstResponder];
    }
    else {
        NSLog(@"Should submit the query");
        [self attemptlogin:textField];
    }
    return YES;
}

@end