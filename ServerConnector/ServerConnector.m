//
//  ServerConnector.m
//  Quizer
//
//  Created by Olof Dahlbom on 2011-08-21.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ServerConnector.h"
#import "ViewController.h"

@implementation ServerConnector
@synthesize navController;

@synthesize delegate;

- (id)initAndCreateUIForDevice:(NSString *)deviceName
{
    if (self = [super init])
    {
        NSMutableString *SBName = [NSMutableString stringWithString:@"ServerConnector_"];
        [SBName appendString:deviceName];
        self.navController = [self loadUIWithStoryBoardName:SBName];
        [[[self.navController viewControllers] objectAtIndex:0] setDelegate:self];
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
@end
