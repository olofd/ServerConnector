//
//  DetailsViewController.m
//  ServerConnector
//
//  Created by Olof Dahlbom on 2011-08-14.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailsViewController.h"

@implementation DetailsViewController
@synthesize dictWithServerDetails;

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DetailsCell"];
    
    if (indexPath.row == 0)
    {
        NSString *stringWithName = [dictWithServerDetails objectForKey:@"Name"];
        [cell.textLabel setText:stringWithName];
        [cell.detailTextLabel setText:@"Name"];
    }
    if (indexPath.row == 1)
    {
        NSString *stringWithName = [dictWithServerDetails objectForKey:@"IP/DNS"];
        [cell.textLabel setText:stringWithName];
                [cell.detailTextLabel setText:@"IP/DNS"];
    }
    if (indexPath.row == 2)
    {
        NSString *stringWithName = [dictWithServerDetails objectForKey:@"Port"];
        [cell.textLabel setText:stringWithName];
                [cell.detailTextLabel setText:@"Port"];
    }
    if (indexPath.row == 3)
    {
        NSString *stringWithName = [dictWithServerDetails objectForKey:@"Root"];
        [cell.textLabel setText:stringWithName];
                [cell.detailTextLabel setText:@"Root"];
    }
    if (indexPath.row == 4)
    {
        NSString *stringWithName = [dictWithServerDetails objectForKey:@"ID"];
        [cell.textLabel setText:stringWithName];
                [cell.detailTextLabel setText:@"ID"];
    }


    
    return cell;
}
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

@end
