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

@synthesize activityView;
@synthesize imageView;
@synthesize lableWithServerName;
@synthesize pickerView;
@synthesize plistController;


@synthesize arrayWithServerConnections;
@synthesize labelWithActiveServerName;

@synthesize delegate;

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
            detailsViewController.dictWithServerDetails = [self.arrayWithServerConnections objectAtIndex:[pickerView selectedRowInComponent:0]];
        }
    }
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self startServerConector];
	// Do any additional setup after loading the view, typically from a nib.

    
}

- (void)startServerConector
{
    [activityView setHidden:YES];
    
    plistController = [[PlistServerController alloc] init];
    
    [self reloadServerConnections];
    [self readActiveServerToLabel]; 
}
- (IBAction)exitServerConnector:(id)sender {
    [delegate serverConnectorWillExit];
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
    
    [self.imageView setHidden:YES];
    [self.activityView setHidden:NO];
    [self.activityView startAnimating];
    dispatch_queue_t testServer = dispatch_queue_create("Test-Server-Thread", NULL);
    dispatch_async(testServer, ^{
        
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
        
        [self.imageView setHidden:NO];
        [self.activityView setHidden:YES];
        [self.activityView stopAnimating];
    });
    
    dispatch_release(testServer);
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
    
    [self.imageView setHidden:YES];
    [self.activityView setHidden:NO];
    [self.activityView startAnimating];
    
    dispatch_queue_t chooseServer = dispatch_queue_create("Choose Server Thread", NULL);
    dispatch_async(chooseServer, ^{
        
        
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
        [self.imageView setHidden:NO];
        [self.activityView setHidden:YES];
        [self.activityView stopAnimating];
    });
    
    
    dispatch_release(chooseServer);
}

- (NSString *)activeServer 
{
    
    NSString *activeServer ;
    activeServer = [[plistController readActiveServer] objectForKey:@"Name"];
    
    return activeServer;
}


- (void)readActiveServerToLabel
{
    NSString *nameOfServerThatIsActive;
    
    nameOfServerThatIsActive = [NSString stringWithFormat:@"Active Server: %@", [self activeServer]];
    
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
    [self setImageView:nil];
    [self setActivityView:nil];
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
