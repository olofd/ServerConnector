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
@synthesize navController, rootController, dataParser, model;

@synthesize delegate;

- (id)initAndCreateUIForDevice:(NSString *)deviceName
{
    if (self = [super init])
    {
        NSMutableString *SBName = [NSMutableString stringWithString:@"ServerConnector_"];
        [SBName appendString:deviceName];
        
        self.model = [[ServerConnectorModel alloc] init];
        dataParser = [[DataParser alloc] init];

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
    return actionSheet;

}

#pragma -
#pragma mark ServerConnectorActions

- (void)loginWithUserName:(NSString *)userName andPassword:(NSString *)password
{
    loginValid = NO;
    
    dispatch_queue_t loginThread = dispatch_queue_create("Login-thread", NULL);
    dispatch_async(loginThread, ^{
    
        NSArray *arrayWithUsernameAndPassword = [NSArray arrayWithObjects:userName, password, nil];
        
    if([dataParser loginOnServer:[self requestActiveServerData] withUsername:userName andPassword:password])
    {
        [self performSelectorOnMainThread:@selector(didLogInWithCredentials:) withObject:arrayWithUsernameAndPassword waitUntilDone:YES];
    }else
    {
        [self performSelectorOnMainThread:@selector(didLogInWithCredentials:) withObject:NULL waitUntilDone:YES];
        
    }

    });
    

    dispatch_release(loginThread);
    

}


- (void)didLogInWithCredentials:(NSArray *)arrayWithUserAndPassword 
{
    
    if (arrayWithUserAndPassword != NULL)
    {
        NSLog(@"Successfull Login with username %@", [arrayWithUserAndPassword objectAtIndex:0]);
        [delegate didLoginSuccesfully:YES];
    }else
    {
        NSLog(@"Login failed with username %@", [arrayWithUserAndPassword objectAtIndex:0]);
        [delegate didLoginSuccesfully:NO];

    }
    
    
}

- (void)registerNewUser:(NSDictionary *)userDetails
{
    dispatch_queue_t registerThread = dispatch_queue_create("Register-thread", NULL);
    dispatch_async(registerThread, ^{
       
        if([dataParser registerNewUserOnServer:[self requestActiveServerData] withUserDetails:userDetails])
        {
            [delegate showUIActionSheetWithString:@"Regristration successfull!"];
        }else
        {
            [delegate showUIActionSheetWithString:@"Regristration failed!"];

        }
        
    });

    
    
}

- (void)errorWhileLoadingDataWithInfo:(NSString *)info
{
    NSLog(@"%@", info);
}





@end
