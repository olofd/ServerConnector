//
//  ViewController.h
//  ServerConnector
//
//  Created by Olof Dahlbom on 2011-08-09.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddServerViewController.h"
#import "PlistServerController.h"

@interface ViewController : UIViewController<UIPickerViewDataSource, AddServerDelegate>
{
    
    UIPickerView *pickerView;
    NSArray *arrayWithServerConnections;
    
    PlistServerController *plistController;
    

}

- (IBAction)addServer:(id)sender;
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)reloadServerConnections;

//Protocol actions:
- (void)dissmiss;
- (void)didAddServerNowDissmissWithDict:(NSDictionary *)dict;

//Propertys
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) PlistServerController *plistController;
@property (strong, nonatomic) NSArray *arrayWithServerConnections;

@end
