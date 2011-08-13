//
//  AddServerViewController.h
//  ServerConnector
//
//  Created by Olof Dahlbom on 2011-08-12.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputCellTableViewCell.h"

@protocol AddServerDelegate <NSObject>

-(NSArray *)didAddServerNowDissmiss;
    
@end
@interface AddServerViewController : UIViewController <UITableViewDataSource, UITextFieldDelegate>
{
    UITableView *tableView;
    
    NSArray *arrayWithFields;
    NSArray *arrayWithPlaceHolders;
    
    UITextField *nameTextField;
    UITextField *ipTextField;
    UITextField *portTextField;
    UITextField *rootTextField;
    UITextField *idTextField;


}
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@property (strong, nonatomic) IBOutlet UITextField *name;

@property (strong, nonatomic) NSArray *arrayWithPlaceHolders;
@property (strong, nonatomic) NSArray *arrayWithFields;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end