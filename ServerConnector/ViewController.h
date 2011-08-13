//
//  ViewController.h
//  ServerConnector
//
//  Created by Olof Dahlbom on 2011-08-09.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource>
{
    
    UIPickerView *pickerView;
    NSMutableArray *arrayColors;
}
- (IBAction)addServer:(id)sender;
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@end
