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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
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
    
    SC = [[ServerConnector alloc] initAndCreateUIForDevice:@"iPhone"];
    SC.delegate = self;
    
    [self presentModalViewController:SC.navController animated:YES];
    
}

-(void)serverConnectorWillExit;
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
