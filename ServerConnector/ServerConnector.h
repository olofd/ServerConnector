//
//  ServerConnector.h
//  Quizer
//
//  Created by Olof Dahlbom on 2011-08-21.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@protocol ServerConnectorDelegate <NSObject>

-(void)serverConnectorWillExit;

@end

@interface ServerConnector : NSObject<ServerConnectorViewControllerDelegate>
{
    UINavigationController *navController;
}

- (id)initAndCreateUIForDevice:(NSString *)deviceName;
- (id)loadUIWithStoryBoardName:(NSString *)SBname;

@property (weak, nonatomic) id<ServerConnectorDelegate> delegate;
@property (strong, nonatomic) UINavigationController *navController;
@end
