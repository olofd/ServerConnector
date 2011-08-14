//
//  InputCellTableViewCell.m
//  ServerConnector
//
//  Created by Olof Dahlbom on 2011-08-12.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InputCellTableViewCell.h"

@implementation InputCellTableViewCell
@synthesize nameTextField, ipTextField, portTextField, rootTextField, idTextField;

- (id)init{
    self = [super init];
    if (self)
    {
        [self setUp];
        
    }else
    {
        NSLog(@"Något gick snett!");
    }
    
    return self;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code


    }
    return self;
}

- (void)setUp{
    
    arrayWithTextFields = [[NSArray alloc]initWithObjects:self.nameTextField, self.ipTextField, self.portTextField, self.rootTextField, self.idTextField, nil];
    
    
    for (UITextField *a in arrayWithTextFields)
    {
        [a setDelegate:self];
        [a setReturnKeyType:UIReturnKeyDone];
    }
    
}

-(BOOL) textFieldShouldReturn:(UITextField*) textField {
    [self.nameTextField resignFirstResponder]; 
    [self.ipTextField resignFirstResponder]; 
    [self.portTextField resignFirstResponder]; 
    [self.rootTextField resignFirstResponder]; 
    [self.idTextField resignFirstResponder];

    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    

    // Configure the view for the selected state
}

@end
