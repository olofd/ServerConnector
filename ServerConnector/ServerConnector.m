//
//  ServerConnector.m
//  Quizer
//
//  Created by Olof Dahlbom on 2011-08-21.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ServerConnector.h"
#import "ViewController.h"
#pragma mark -
#pragma mark Initialization

@implementation ServerConnector
@synthesize navController, rootController, dataParser;

@synthesize delegate;

- (id)initAndCreateUIForDevice:(NSString *)deviceName
{
    if (self = [super init])
    {
        NSMutableString *SBName = [NSMutableString stringWithString:@"ServerConnector_"];
        [SBName appendString:deviceName];
        self.navController = [self loadUIWithStoryBoardName:SBName];
        self.rootController =[[self.navController viewControllers] objectAtIndex:0];
        self.rootController.delegate = self;
        [self.rootController startServerConector];
        
    }
    return self;
}

- (id)loadUIWithStoryBoardName:(NSMutableString *)SBname;
{
    UIStoryboard *SB = [[UIStoryboard alloc] init];
    SB = [UIStoryboard storyboardWithName:SBname bundle:nil];
    if (SB == nil)
    {
        NSLog(@"Error while creating StoryBoard!");
        return nil;
    }
    return [SB instantiateInitialViewController];
}

-(void)serverConnectorWillExit {
    
    [delegate serverConnectorWillExit];
}

#pragma -
#pragma mark ServerConnectorControllerAPI

- (NSString *)requestActiveServer {    
    return [[self.rootController.plistController readActiveServer]valueForKey:@"Name"];
    
}

- (void)setActiveServerWithDict:(NSDictionary *)dict DisplayResultInUI:(BOOL)displayResult
{
    [self addServerToListOFServrersWithDict:dict];
    
    dispatch_queue_t chooseServer = dispatch_queue_create("Choose Server Thread", NULL);
    dispatch_async(chooseServer, ^{
        
    
            if([self testServerWithName:[dict valueForKey:@"Name"]])
            {
                [self.rootController.plistController chooseServerWithDict:dict];
                
                if (displayResult == YES)
                {
                [self.delegate showUIActionSheetWithString:[NSString stringWithFormat:@"Server with name %@ is now active!", [dict valueForKey:@"Name"]]];
                }else
                {
                    NSLog(@"Server %@ set as active!", [dict valueForKey:@"Name"]);
                }
            }else
            {
                if (displayResult == YES)
                {
                [self.delegate showUIActionSheetWithString:[NSString stringWithFormat:@"Server with name %@ is NOT responding!", [dict valueForKey:@"Name"]]]; 
                }else
                {
                    NSLog(@"Server with name %@ is NOT responding!", [dict valueForKey:@"Name"]);

                }
            }
    });
    
    dispatch_release(chooseServer);

}


- (NSDictionary *)requestActiveServerData {
    
    return [self.rootController.plistController readActiveServer];
}

- (NSArray *)requestArrayWithAllServers
{
    return [self.rootController.plistController readPlistToArrayWithServerConnections];
}

- (void)addServerToListOFServrersWithDict:(NSDictionary *)dict
{
    [self.rootController.plistController writePlistWithDictionaryWithServerConnections:dict];
}

- (BOOL)testServerWithName:(NSString *)name {
    
    NSDictionary *dictionary;
    
    
    for (id dict in self.rootController.arrayWithServerConnections)
    {
        if ([[dict valueForKey:@"Name"] isEqualToString:name])
            {
                
                dictionary = dict;
                
            }
     }

    
    
    if (dictionary == NULL)
    {
        return NO;

    }else
    {
     if ([self.rootController.plistController checkServerConnectionWithDictionary:dictionary])
     {
         return YES;
     }else
     {
         return NO;
     }
    }
    
}
  
- (UIActionSheet *)constructUIActionSheetWithString:(NSString *)stringToShow
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:stringToShow
                                                             delegate:nil cancelButtonTitle:nil destructiveButtonTitle:@"OK" otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    NSLog(@"Hello");
    return actionSheet;

}

#pragma -
#pragma mark ServerConnectorActions

- (void)loginWithUserName:(NSString *)userName andPassword:(NSString *)password
{
    dispatch_queue_t loginThread = dispatch_queue_create("Login-thread", NULL);
    dispatch_async(loginThread, ^{
    
    dataParser = [[DataParser alloc] init];
    
    if([dataParser loginOnServer:[self requestActiveServerData] withUsername:userName andPassword:password])
    {
        [self didLogInWithCredentials:userName andPassword:password];
        
 
    }else
    {
        [self.delegate showUIActionSheetWithString:@"Login Failed!"];
        [self errorWhileLoadingDataWithInfo:@"Login Failed!"];
    }
    
    });
    
    dispatch_release(loginThread);
}

- (void)didLogInWithCredentials:(NSString *)userName andPassword:(NSString *)password
{
    
    NSLog(@"Did Login with username %@", userName);
    
}
- (void)errorWhileLoadingDataWithInfo:(NSString *)info
{
    NSLog(@"%@", info);
}



@end
