//
//  PlistController.h
//  SteenX
//
//  Created by Olof Dahlbom on 2011-07-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistServerController : NSObject
{
    NSArray *arrayWithServers;
}

- (BOOL)writePlistWithDictionaryWithServerConnections:(NSDictionary *)dictionary;
- (NSMutableArray *)readPlistToArrayWithServerConnections;
- (NSDictionary *)checkServerSpellingInDictionary:(NSDictionary *)dictionary;
- (NSString *)checkIfIPDNSHasHttpWithString:(NSString *)IPDNS;
- (BOOL)checkServerConnectionWithDictionary:(NSDictionary *)dict;

- (BOOL)chooseServerWithName:(NSString *)serverName;

@property (nonatomic, retain) NSArray *arrayWithServers;

@end
