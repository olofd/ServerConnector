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
#import "DetailsViewController.h"

@implementation ViewController

@synthesize lableWithServerName;
@synthesize pickerView;
@synthesize plistController;


@synthesize arrayWithServerConnections;
@synthesize labelWithActiveServerName;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"addServer"])
    {
        AddServerViewController *addServer = [segue destinationViewController];
        addServer.delegate = self;
    }
    if([[segue identifier] isEqualToString:@"showServerDetails"])
    {
        DetailsViewController *detailsViewController = [segue destinationViewController];
       // detailsViewController.delegate = self;
        
        if ([self.arrayWithServerConnections count] > 0)
        {
        detailsViewController.dictWithServerDetails = [arrayWithServerConnections objectAtIndex:[pickerView selectedRowInComponent:0]];
        }
    }

}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    plistController = [[PlistServerController alloc] init];
    
    [self reloadServerConnections];
    [self readActiveServerToLabel];
        
}
- (IBAction)reloadAction:(id)sender {
    [self reloadServerConnections];
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
    
    [pickerView reloadComponent:0];
    if ([self.arrayWithServerConnections count] != 0)
    {
        [self pickerView:pickerView didSelectRow:0 inComponent:0];    
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.arrayWithServerConnections count] != 0)
    {
    self.lableWithServerName.text = [[self.arrayWithServerConnections objectAtIndex:row]objectForKey:@"Name"];
    }
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

- (IBAction)deleteServerAction:(id)sender {
        
    if ([self.arrayWithServerConnections count] == 0)
    {
[self showMessageBoxWithString:@"Nothing to delete!"];
 
 }else
    {

        
    
    [self.plistController deleteServerWithName:[[self.arrayWithServerConnections objectAtIndex:[pickerView selectedRowInComponent:0]]objectForKey:@"Name"]];


    [self reloadServerConnections];
    [pickerView selectRow:[pickerView selectedRowInComponent:0] - 1 inComponent:0 animated:YES];
    }
    
    [self readActiveServerToLabel];
    
}

- (IBAction)testServerAction:(id)sender {
    
    if ([self.arrayWithServerConnections count] > 0)
    {
     
    if ([self testServerMethod])
    {
        [self showMessageBoxWithString:@"Server is working!"];
    }else
    {
        [self showMessageBoxWithString:@"Server is NOT working!"];

    }
    }
    
}

-(BOOL)testServerMethod
{
    bool serverStatus = [plistController checkServerConnectionWithDictionary:[self.arrayWithServerConnections objectAtIndex:[pickerView selectedRowInComponent:0]]];
    
    if (serverStatus == YES)
    {
        return YES;
    }else
    {
        return NO;
        
    }
}

- (IBAction)chooseServerAction:(id)sender {
    
    if ([self.arrayWithServerConnections count] > 0)
    {
    if([self testServerMethod])
    {
        [plistController chooseServerWithDict:[self.arrayWithServerConnections objectAtIndex:[pickerView selectedRowInComponent:0]]];
        [self readActiveServerToLabel];
    }else
    {
        [self showMessageBoxWithString:@"This server is not responding and can't be choosen!"];
    }
    }
}

- (void)readActiveServerToLabel
{
    NSString *nameOfServerThatIsActive;
    
    nameOfServerThatIsActive = [NSString stringWithFormat:@"Active Server: %@", [[plistController readActiveServer] objectForKey:@"Name"]];

    if (nameOfServerThatIsActive != nil)
    {
        self.labelWithActiveServerName.text = nameOfServerThatIsActive;
    }else
    {
        self.labelWithActiveServerName.text = @"No Active Server!";
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
}

- (void)showMessageBoxWithString:(NSString *)stringToShow
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:stringToShow
                                                             delegate:nil cancelButtonTitle:nil destructiveButtonTitle:@"OK" otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view];	
}


- (void)viewDidUnload
{
    [self setPickerView:nil];
    [self setLableWithServerName:nil];
    labelWithActiveServerName = nil;
    [self setLabelWithActiveServerName:nil];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
@end
