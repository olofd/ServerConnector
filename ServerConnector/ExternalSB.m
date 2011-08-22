//
//  ExternalSB.m
//  ServerConnector
//
//  Created by Olof Dahlbom on 2011-08-22.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ExternalSB.h"
#import "ServerConnector.h"

@implementation ExternalSB


@synthesize userNameField;
@synthesize passwordField;
@synthesize activeServerLabel;
@synthesize SC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SC = [[ServerConnector alloc] initAndCreateUIForDevice:@"iPhone"];
    SC.delegate = self;
    
    NSLog(@"%@", [self.SC requestActiveServer]);
    [self updateLabel];
    
    
    NSLog(@"%d",[self.SC testServerWithName:@"Local"]);

    
    
    NSArray *keys = [NSArray arrayWithObjects:@"Name", @"IP/DNS", @"Port", @"Root", @"ID", nil];
    NSArray *value = [NSArray arrayWithObjects:@"NicklasServer", @"http://127.0.0.1", @"9888", @"ServerConnector", @"1", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:value forKeys:keys];
//    
    [self.SC setActiveServerWithDict:dict DisplayResultInUI:NO]; 
   // [self showUIActionSheetWithString:@"Hej"];
    //Updating Label

    [self.userNameField setDelegate:self];
    [self.userNameField setReturnKeyType:UIReturnKeyDone];
    [self.passwordField setDelegate:self];
    [self.passwordField setReturnKeyType:UIReturnKeyDone];
}
-(BOOL) textFieldShouldReturn:(UITextField*) textField {

    [userNameField resignFirstResponder];
    [passwordField resignFirstResponder];

    return YES;
}

-(void)showUIActionSheetWithString:(NSString *)stringToShow {
    
    UIActionSheet *action = [[UIActionSheet alloc] init];
    action = [self.SC constructUIActionSheetWithString:stringToShow];
    [action showInView:self.view];
}

- (void)updateLabel
{
    self.activeServerLabel.text = [NSString stringWithFormat:@"Active Server: %@", [self.SC requestActiveServer]];
}

- (void)viewDidUnload
{
    [self setActiveServerLabel:nil];

    [self setUserNameField:nil];
    [self setPasswordField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)startSB:(id)sender {
    

    
    [self presentModalViewController:SC.navController animated:YES];
    
}

- (IBAction)loginAction:(id)sender {
    
    [self.SC loginWithUserName:self.userNameField.text andPassword:self.passwordField.text];
}

-(void)serverConnectorWillExit;
{
    [self dismissModalViewControllerAnimated:YES];
    [self updateLabel];

}
@end
