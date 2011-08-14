//
//  DataParser.m
//  SteenX
//
//  Created by Olof Dahlbom on 2011-07-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataParser.h"
#import "SBJsonParser.h"


@implementation DataParser
@synthesize parser;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        parser = [[SBJsonParser alloc] init];
    } 
    return self;
}

-(NSArray *)loginWithUsername:(NSString *)user AndPassword:(NSString *)password
{
    //Testar Server:
 //   [self testServerWithClientId:@"SteenX"];
 
    NSString *serverUrl = [NSString stringWithFormat:@"http://127.0.0.1"];
    NSString *port = [NSString stringWithFormat:@"8888"];
    NSString *rootFolder = [NSString stringWithFormat:@"SteenX"];

    NSString *URL = [NSString stringWithFormat:@"%@:%@/%@/login.php?username=%@&password=%@",serverUrl, port, rootFolder, user, password];
    
    NSMutableURLRequest* post = [NSURLRequest requestWithURL:[NSURL URLWithString:[URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]];
    
    
    NSURLResponse* response;
    NSError* error;
    NSData* result = [NSURLConnection sendSynchronousRequest:post returningResponse:&response error:&error];
      //  NSLog(@"%@", [[[NSString alloc] initWithData:result encoding:NSASCIIStringEncoding] autorelease]);
    NSString *resultString = [[NSString alloc] initWithData:result encoding:NSASCIIStringEncoding];
    
    
    if ([resultString boolValue] == true)
    {
        NSLog(@"Inloggad! %@", resultString);
     
    }
    
    else
    {
        NSLog(@"Inloggning misslyckades!");
        return NULL;
    }
    
    
    return NULL;
}

- (BOOL)testServerWithDictionary:(NSDictionary *)dict
{
    NSString *testURL = [NSString stringWithFormat:@"%@:%@/%@/testServer.php?clientid=%@",[dict objectForKey:@"IP/DNS"], [dict objectForKey:@"Port"], [dict objectForKey:@"Root"], [dict objectForKey:@"ID"]];
    
       // NSString *testURL = @"http://127.0.0.1:8888/ServerConnector/testServer.php?clientid=1";
    
    NSMutableURLRequest* post = [NSURLRequest requestWithURL:[NSURL URLWithString:[testURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]];
    
    
    NSURLResponse* response;
    NSError* error;
    NSData* result = [NSURLConnection sendSynchronousRequest:post returningResponse:&response error:&error];
    //  NSLog(@"%@", [[NSString alloc] initWithData:result encoding:NSASCIIStringEncoding]);
    NSString *resultString = [[NSString alloc] initWithData:result encoding:NSASCIIStringEncoding];
    
    
    if ([resultString boolValue] == true)
    {

        return YES;
        
    }
    
    else
    {

        return NO;
    }
    
    
}




@end
