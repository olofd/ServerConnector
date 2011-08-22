//
//  AddServerViewController.m
//  ServerConnector
//
//  Created by Olof Dahlbom on 2011-08-12.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AddServerViewController.h"
#import "InputCellTableViewCell.h"
#import "PlistServerController.h"

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

    //Checks if any of the fields are empty, if they are, displays an error message.
    NSMutableArray *arrayWithTextFromFields = [[NSMutableArray alloc] init];
    NSMutableArray *errorNames = [[NSMutableArray alloc] init];
    
    for (id i in self.arrayWithFields)
    {
        if ([[i text] isEqualToString:@""] || [i text] == NULL)
            {
                [errorNames addObject:[i placeholder]];   
            }else
            {
                [arrayWithTextFromFields addObject:[i text]];
            }
    }
    
    //If there are any errors, display error message:
    if ([errorNames count] > 0)
    {
        [self errorDialogWithErrors:errorNames];
    }else
    {
    
    //Building array with serverinfo to pass to delegate:
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:arrayWithTextFromFields forKeys:self.arrayWithPlaceHolders];
    
    //Passing to delegate
    [delegate didAddServerNowDissmissWithDict:dict];
    }
   
}

- (void)errorDialogWithErrors:(NSMutableArray *)arrayWithErrors
{
    
    //Building a nice formated string from the arrayWithErrors:
    NSString *stringWithErrorMessage = [NSString stringWithFormat:@"You must enter: \n"];
    
    NSMutableString *stringToConcatenate = [[NSMutableString alloc] initWithString:stringWithErrorMessage];
    
    //Adds each error to the string:
    for (int i = 0;i < [arrayWithErrors count]; i++)
    {
        //If it's only one error to add, or only one error LEFT to add, do not add a comma (haha, I know =)
        if ([arrayWithErrors count] - i == 1)
        {
          [stringToConcatenate appendFormat:@"%@", [arrayWithErrors objectAtIndex:i]];
        }else
        {
        [stringToConcatenate appendFormat:@"%@, ", [arrayWithErrors objectAtIndex:i]];
        }
    
    }
	// open a dialog with just an OK button
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:stringToConcatenate
                                                             delegate:nil cancelButtonTitle:nil destructiveButtonTitle:@"OK" otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view];	// show from our table view (pops up in the middle of the table)
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.arrayWithFields count];
}
-(UITableViewCell *)tableView:(UITableView *)tableViewIn cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:@"Reuse"];
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

// Invoked when interval, counter, or numDigits field is edited to slide up
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   // [self performSelector:@selector(shiftViewForKeyboard:) withObject:nil afterDelay:0];
    if ([textField.placeholder isEqualToString:@"ID"])
    {
        [self shiftViewForKeyboard:@"UP"];
    }
}

// Invoked when interval, counter, or numDigits field is done editing to slide back down
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.placeholder isEqualToString:@"ID"])
    {
        [self shiftViewForKeyboard:@"DOWN"];
    }

}
- (void)shiftViewForKeyboard:(NSString *)direction
{
    const int movementDistance = 40;
    const float movementDuration = 0.3f;
    int movement;
    
    if ([direction isEqualToString:@"UP"])
         {
             movement = (-movementDistance);
         }else
         {
             movement = movementDistance;
         }
    
    [UIView beginAnimations:@"Shift" context:nil];
    [UIView setAnimationDuration:movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
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
