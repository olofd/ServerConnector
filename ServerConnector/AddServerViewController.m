//
//  AddServerViewController.m
//  ServerConnector
//
//  Created by Olof Dahlbom on 2011-08-12.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AddServerViewController.h"
#import "InputCellTableViewCell.h"

@implementation AddServerViewController

@synthesize name;
@synthesize arrayWithFields, arrayWithPlaceHolders;
@synthesize tableView;
@synthesize delegate;

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

- (IBAction)cancel:(id)sender {
    
    [delegate dissmiss];
}

- (IBAction)save:(id)sender {

    
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.arrayWithFields count];
}
-(UITableViewCell *)tableView:(UITableView *)tableViewIn cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:@"REUSe"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.contentView addSubview:[arrayWithFields objectAtIndex:indexPath.row]];

    return cell;

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
    
    //Setting up the textfields with placeholdertext, frame, delegate and returnkeytype.
    self.arrayWithPlaceHolders = [[NSArray alloc] initWithObjects:@"Name", @"IP/DNS", @"Port", @"Root", @"ID", nil];
    
    CGRect frame = CGRectMake(20.0, 8.0, 260, 31);
    nameTextField = [[UITextField alloc] initWithFrame:frame];
    ipTextField = [[UITextField alloc] initWithFrame:frame];
    portTextField = [[UITextField alloc] initWithFrame:frame];
    rootTextField = [[UITextField alloc] initWithFrame:frame];
    idTextField = [[UITextField alloc] initWithFrame:frame];
    
    self.arrayWithFields = [[NSArray alloc]initWithObjects:nameTextField, ipTextField, portTextField, rootTextField, idTextField, nil];
    
    NSInteger a = 0;
    for (id i in self.arrayWithFields)
    {

        [i setPlaceholder:[self.arrayWithPlaceHolders objectAtIndex:a]];
        [i setDelegate:self];
        [i setReturnKeyType:UIReturnKeyDone];

                a++;
    }

    [super viewDidLoad];
    
}
-(BOOL) textFieldShouldReturn:(UITextField*) textField {

    for (id i in self.arrayWithFields)
    {
        [i resignFirstResponder];
    }
    
    return YES;
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
         [self setTableView:nil];

    [self setName:nil];
         [super viewDidUnload];
     }
@end
