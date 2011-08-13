//
//  InputCellTableViewCell.h
//  ServerConnector
//
//  Created by Olof Dahlbom on 2011-08-12.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputCellTableViewCell : UITableViewCell <UITextFieldDelegate>
{
    
    UITextField *nameTextField;
    UITextField *ipTextField;
    UITextField *portTextField;
    UITextField *rootTextField;
    UITextField *idTextField;
    
    NSArray *arrayWithTextFields;

}

- (void)setUp;
-(BOOL) textFieldShouldReturn:(UITextField*) textField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *ipTextField;
@property (strong, nonatomic) IBOutlet UITextField *portTextField;
@property (strong, nonatomic) IBOutlet UITextField *rootTextField;
@property (strong, nonatomic) IBOutlet UITextField *idTextField;
@end
