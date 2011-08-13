//
//  ViewController.h
//  ServerConnector
//
//  Created by Olof Dahlbom on 2011-08-09.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddServerViewController.h"

@interface ViewController : UIViewController<UIPickerViewDataSource, AddServerDelegate>
{
    
    UIPickerView *pickerView;
    NSMutableArray *arrayColors;
    

}
- (IBAction)addServer:(id)sender;
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)dissmiss;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@end
