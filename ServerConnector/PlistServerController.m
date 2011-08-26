//
//  PlistController.m
//  SteenX
//
//  Created by Olof Dahlbom on 2011-07-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlistServerController.h"
#import "DataParser.h"

@implementation PlistServerController
@synthesize arrayWithServers;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (BOOL)writePlistWithDictionaryWithServerConnections:(NSDictionary *)dictionary
{
 
    //dictionary = [self checkServerSpellingInDictionary:dictionary];
    //BOOL connectionCheck = [self checkServerConnectionWithDictionary:dictionary];
    BOOL connectionCheck = YES;
    if (connectionCheck == true)
    {

        
        NSString *error;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *plistPath = [rootPath stringByAppendingPathComponent:@"ServerConnectorData.plist"];
    
    NSMutableArray *arrayWithDictionarys = [self readPlistToArrayWithServerConnections];
    if (arrayWithDictionarys == NULL)
    {
        arrayWithDictionarys = [[NSMutableArray alloc] init];
    }
    
    [arrayWithDictionarys addObject:dictionary];

    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:arrayWithDictionarys
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
        
    }
    else {
        NSLog(@"%@", error);
    }
        return true;
    }
else
{

    return false;
}
}

- (BOOL)writePlistWithArrayContaningAllConnections:(NSMutableArray *)arrayWithCompleteServerList
{
    BOOL connectionCheck = YES;
    if (connectionCheck == true)
    {
        
        NSString *error;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *plistPath = [rootPath stringByAppendingPathComponent:@"ServerConnectorData.plist"];

        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:arrayWithCompleteServerList
                                                                       format:NSPropertyListXMLFormat_v1_0
                                                             errorDescription:&error];
        if(plistData) {
            [plistData writeToFile:plistPath atomically:YES];
            
        }
        else {
            NSLog(@"%@", error);
        }
        
        [self readPlistToArrayWithServerConnections];
        return true;
    }
    else
    {
        
        return false;
    }

}

- (NSArray *)readPlistToArrayWithServerConnections
{

    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"ServerConnectorData.plist"];
    
    NSMutableArray *arrayWithDictionarys = [NSMutableArray arrayWithContentsOfFile:plistPath];
    
    if (arrayWithDictionarys != NULL)
    {
        self.arrayWithServers = arrayWithDictionarys;
        
    return arrayWithDictionarys;
    }
    return NULL;
}

- (void)deleteServerWithName:(NSString *)name;
{
    NSMutableArray *arrayWithDeleter = [[NSMutableArray alloc] init];
    
    for (id i in self.arrayWithServers)
         {
             [arrayWithDeleter addObject:i];   
         }
    
    int a;
    bool didFindName;
    
     for (int i = 0; i < [self.arrayWithServers count];i++)
    {
        if ([[[self.arrayWithServers objectAtIndex:i]objectForKey:@"Name"] isEqualToString:name])
        {
            a = i;
            didFindName = YES;
        }
    }
    
    
    if (didFindName == YES)
    {

    if ([[[arrayWithDeleter objectAtIndex:a] objectForKey:@"Name"]isEqualToString:
          [[self readActiveServer]objectForKey:@"Name"]])
         {
             [self deleteActiveServer];
         }
         
            [arrayWithDeleter removeObjectAtIndex:a];
    }
  
    
    NSLog(@"%@", arrayWithDeleter);
    
    [self writePlistWithArrayContaningAllConnections:arrayWithDeleter];
    
    
}

- (void)deleteActiveServer
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"ServerConnectorActiveServer.plist"];   
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
		[[NSFileManager defaultManager] removeItemAtPath:plistPath error:NULL];
	}
}

- (NSDictionary *)checkServerSpellingInDictionary:(NSDictionary *)dictionary {
    
    NSString *checkedIPDNS;
    
    checkedIPDNS = [self checkIfIPDNSHasHttpWithString:[dictionary objectForKey:@"IP/DNS"]];
    
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects:
                               [NSArray arrayWithObjects:
                                [dictionary objectForKey:@"Servername"], checkedIPDNS, [dictionary objectForKey:@"Root"], [dictionary objectForKey:@"Port"], [dictionary objectForKey:@"ClientID"],  nil]
                                                          forKeys:[NSArray arrayWithObjects: @"Servername", @"IP/DNS", @"Root", @"Port", @"ClientID", nil]];
    
    return plistDict;
    
}

- (NSString *)checkIfIPDNSHasHttpWithString:(NSString *)IPDNS{
    
    NSString *newIPDNS = @"";
    NSMutableString *buildString = [NSMutableString stringWithString:@""];
    
    if ([IPDNS length] >= 7)
    {
        for (int i =0 ; i < 7; i++) {
            unichar ch;
            ch = [IPDNS characterAtIndex:i];
            
            [buildString appendFormat:@"%c", ch];
        }
        
    }
    if ([buildString isEqualToString:@"http://"])
    {
        NSLog(@"IS COMPLETE!");
        newIPDNS = IPDNS;
        return newIPDNS;
    }
    else
    {
        
        NSLog(@"IS NOT COMPLETE!");
        NSString *newIPDNS = [NSString stringWithFormat:@"http://%@",IPDNS];
        
        NSLog(@"%@", newIPDNS);
        return newIPDNS;
    }

}

- (BOOL)checkServerConnectionWithDictionary:(NSDictionary *)dict {
    
    DataParser *controller = [[DataParser alloc] init];
    BOOL result = [controller testServerWithDictionary:dict];
    
    return result;
    
}



- (void)chooseServerWithDict:(NSDictionary *)dict
{

            NSString *error;
            NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *plistPath = [rootPath stringByAppendingPathComponent:@"ServerConnectorActiveServer.plist"];   
            
            NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:dict
                                                                           format:NSPropertyListXMLFormat_v1_0
                                                                 errorDescription:&error];
            if(plistData) {
                [plistData writeToFile:plistPath atomically:YES];
                
            }
            else {
                NSLog(@"%@", error);
                
            }
            
}

- (NSDictionary *)readActiveServer
{
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"ServerConnectorActiveServer.plist"];
    
    NSDictionary *dictWithActiveServer = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    if (dictWithActiveServer != NULL)
    {
        
        return dictWithActiveServer;
    }else
    {
        return nil;
    }
}

@end
