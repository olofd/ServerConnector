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
@synthesize parser, plistController;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        parser = [[SBJsonParser alloc] init];
    } 
    return self;
}

-(BOOL)loginOnServer:(NSDictionary *)dict withUsername:(NSString *)userName andPassword:(NSString *)password
{
 
    NSString *URL = [NSString stringWithFormat:@"%@:%@/%@/login.php?username=%@&password=%@",[dict objectForKey:@"IP/DNS"], [dict objectForKey:@"Port"], [dict objectForKey:@"Root"], userName, password];
    
    NSMutableURLRequest* post = [NSURLRequest requestWithURL:[NSURL URLWithString:[URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]];
    
    
    NSURLResponse* response;
    NSError* error;
    NSData* result = [NSURLConnection sendSynchronousRequest:post returningResponse:&response error:&error];
      //  NSLog(@"%@", [[[NSString alloc] initWithData:result encoding:NSASCIIStringEncoding] autorelease]);
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

- (BOOL )registerNewUserOnServer:(NSDictionary *)dict withUserDetails:(NSDictionary *)userDetails
{
        NSString *URL = [NSString stringWithFormat:@"%@:%@/%@/registerUser.php?username=%@&password=%@&email=%@",
                        [dict objectForKey:@"IP/DNS"], 
                        [dict objectForKey:@"Port"], 
                        [dict objectForKey:@"Root"], 
                        [userDetails objectForKey:@"Username"], 
                        [userDetails objectForKey:@"Password"],
                         [userDetails objectForKey:@"Email"]];

    NSMutableURLRequest* post = [NSURLRequest requestWithURL:[NSURL URLWithString:[URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]];
    
    
    NSURLResponse* response;
    NSError* error;
    NSData *result = [NSURLConnection sendSynchronousRequest:post returningResponse:&response error:&error];
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
- (NSArray *)downloadArrayWithInformationWithDict:(NSDictionary *)dict andIdentifier:(NSString *)identifier;
{
    NSString *scriptName;
    //Should be more generic:
    if ([identifier isEqualToString:@"Categories"])
    {
        scriptName = @"loadAllCategories.php";
    }else if ([identifier isEqualToString:@"Languages"])
    {        
        scriptName = @"loadAllLanguages.php";

    }
        NSString *URL = [NSString stringWithFormat:@"%@:%@/%@/%@",[dict objectForKey:@"IP/DNS"], [dict objectForKey:@"Port"], [dict objectForKey:@"Root"], scriptName];

            NSError* error;
        NSString *rawJSON = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:URL] encoding:NSUTF8StringEncoding error:&error];
        [rawJSON UTF8String];
        
        
        if (parser == NULL)
        {
        parser = [[SBJsonParser alloc] init];
        }
    
        NSArray *arrayWithData = [[parser objectWithString:rawJSON error:nil] copy];

        return arrayWithData;
        
}



@end
