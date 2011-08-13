//
//  ViewController.m
//  ServerConnector
//
//  Created by Olof Dahlbom on 2011-08-09.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "PlistServerController.h"
#import "AddServerViewController.h"

@implementation ViewController
@synthesize pickerView;
@synthesize plistController;

@synthesize arrayWithServerConnections;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"addServer"])
    {
        AddServerViewController *addServer = [segue destinationViewController];
        addServer.delegate = self;
         NSLog(@"HEJBAJS");   
    }
    

}
- (void)dissmiss;
{
    [self dismissModalViewControllerAnimated:YES];  
}

- (void)didAddServerNowDissmissWithDict:(NSDictionary *)dict;
{

    
    [plistController writePlistWithDictionaryWithServerConnections:dict];
    [self dismissModalViewControllerAnimated:YES];
    [self reloadServerConnections];
    [pickerView reloadComponent:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    plistController = [[PlistServerController alloc] init];
    
    [self reloadServerConnections];
    NSLog(@"%@", arrayWithServerConnections);

    
}

- (void)reloadServerConnections
{
    if (self.arrayWithServerConnections == nil)
    {
        self.arrayWithServerConnections = [[NSArray alloc]initWithArray:[plistController readPlistToArrayWithServerConnections]];
    }else
    {
        self.arrayWithServerConnections = [plistController readPlistToArrayWithServerConnections];
    }
}

- (void)viewDidUnload
{
    [self setPickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //type=[arrayNo objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [self.arrayWithServerConnections count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [[self.arrayWithServerConnections objectAtIndex:row]objectForKey:@"Name"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)addServer:(id)sender {
    NSLog(@"Hej");
}
@end
