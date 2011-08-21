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
    
}


- (IBAction)startSB:(id)sender;
-(void)serverConnectorWillExit;

@property (strong, nonatomic) ServerConnector *SC;
@end
