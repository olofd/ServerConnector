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

@protocol ServerConnectorViewControllerDelegate <NSObject>

-(void)serverConnectorWillExit;

@end
@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, AddServerDelegate>
{
    
    UIPickerView *pickerView;
    NSArray *arrayWithServerConnections;
    UILabel *labelWithActiveServerName;
    
    PlistServerController *plistController;
    
    
    UILabel *lableWithServerName;
    UIImageView *imageView;
    UIActivityIndicatorView *activityView;
    
}
- (IBAction)deleteServerAction:(id)sender;
- (IBAction)testServerAction:(id)sender;
- (IBAction)chooseServerAction:(id)sender;

-(BOOL)testServerMethod;
- (void)readActiveServerToLabel;
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

- (IBAction)exitServerConnector:(id)sender;
- (void)reloadServerConnections;

//Protocol actions:


- (void)dissmiss;
- (void)didAddServerNowDissmissWithDict:(NSDictionary *)dict;

- (void)showMessageBoxWithString:(NSString *)stringToShow;


//Propertys
@property (weak, nonatomic) id<ServerConnectorViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *lableWithServerName;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) PlistServerController *plistController;
@property (strong, nonatomic) NSArray *arrayWithServerConnections;
@property (strong, nonatomic) IBOutlet UILabel *labelWithActiveServerName;

@end
