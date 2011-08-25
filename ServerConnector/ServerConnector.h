//
//  ServerConnector.h
//  Quizer
//
//  Created by Olof Dahlbom on 2011-08-21.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "DataParser.h"
#import "ServerConnectorModel.h"

@protocol ServerConnectorDelegate <NSObject>

@optional
-(void)serverConnectorWillExit;
-(void)showUIActionSheetWithString:(NSString *)stringToShow;
-(void)didLoginSuccesfully:(BOOL)bolean;

@end


@interface ServerConnector : NSObject<ServerConnectorViewControllerDelegate>
{
    @public
    UINavigationController *navController;
    
    @protected
    ServerConnectorModel *model;
    ViewController *rootController;
    DataParser *dataParser;
    
    bool loginValid;
}

- (id)initAndCreateUIForDevice:(NSString *)deviceName;
- (id)loadUIWithStoryBoardName:(NSString *)SBname;

//Serverconnector Functions:


@property (weak, nonatomic) id<ServerConnectorDelegate> delegate;

@property (strong, nonatomic) ViewController *rootController;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) DataParser *dataParser;
@property (strong, nonatomic) ServerConnectorModel *model;


#pragma -
#pragma mark ServerConnectorApi

- (NSString *)requestActiveServer;
- (void)setActiveServerWithDict:(NSDictionary *)dict DisplayResultInUI:(BOOL)displayResult;
- (NSDictionary *)requestActiveServerData;
- (NSArray *)requestArrayWithAllServers;
- (void)addServerToListOFServrersWithDict:(NSDictionary *)dict;
- (BOOL)testServerWithName:(NSString *)name;
- (UIActionSheet *)constructUIActionSheetWithString:(NSString *)stringToShow;

#pragma -
#pragma mark ServerConnectorActions
- (void)loginWithUserName:(NSString *)userName andPassword:(NSString *)password;
- (void)registerNewUser:(NSDictionary *)userDetails;
- (void)didLogInWithCredentials:(NSArray *)arrayWithUserAndPassword;
- (void)errorWhileLoadingDataWithInfo:(NSString *)info;

- (void)threadReturnLogin:(NSArray *)arrayWithUserAndPassword;

@end
