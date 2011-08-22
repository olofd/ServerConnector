//
//  ExternalSB.h
//  ServerConnector
//
//  Created by Olof Dahlbom on 2011-08-22.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerConnector.h"

@interface ExternalSB : UIViewController<ServerConnectorDelegate>
{
    
    UILabel *activeServerLabel;
}


- (void)updateLabel;
- (IBAction)startSB:(id)sender;

//Protocol:
-(void)serverConnectorWillExit;
-(void)showUIActionSheetWithString:(NSString *)stringToShow;


@property (strong, nonatomic) IBOutlet UILabel *activeServerLabel;
@property (strong, nonatomic) ServerConnector *SC;
@end
