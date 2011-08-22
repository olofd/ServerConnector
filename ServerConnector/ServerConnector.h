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
-(void)showUIActionSheetWithString:(NSString *)stringToShow;

@end


@interface ServerConnector : NSObject<ServerConnectorViewControllerDelegate>
{
    @public
    UINavigationController *navController;
    
    @protected
    ViewController *rootController;
}

- (id)initAndCreateUIForDevice:(NSString *)deviceName;
- (id)loadUIWithStoryBoardName:(NSString *)SBname;

//Serverconnector Functions:


@property (weak, nonatomic) id<ServerConnectorDelegate> delegate;

@property (strong, nonatomic) ViewController *rootController;

@property (strong, nonatomic) UINavigationController *navController;


#pragma -
#pragma mark ServerConnectorApi

- (NSString *)requestActiveServer;
- (void)setActiveServerWithDict:(NSDictionary *)dict DisplayResultInUI:(BOOL)displayResult;
- (NSDictionary *)requestActiveServerData;
- (NSArray *)requestArrayWithAllServers;
- (void)addServerToListOFServrersWithDict:(NSDictionary *)dict;
- (BOOL)testServerWithName:(NSString *)name;
- (UIActionSheet *)constructUIActionSheetWithString:(NSString *)stringToShow;


@end
