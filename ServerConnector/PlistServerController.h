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

- (void)deleteServerWithName:(NSString *)name;

- (BOOL)writePlistWithDictionaryWithServerConnections:(NSDictionary *)dictionary;
- (BOOL)writePlistWithArrayContaningAllConnections:(NSMutableArray *)arrayWithCompleteServerList;


- (NSMutableArray *)readPlistToArrayWithServerConnections;
- (NSDictionary *)checkServerSpellingInDictionary:(NSDictionary *)dictionary;
- (NSString *)checkIfIPDNSHasHttpWithString:(NSString *)IPDNS;
- (BOOL)checkServerConnectionWithDictionary:(NSDictionary *)dict;
- (void)deleteActiveServer;


- (void)chooseServerWithDict:(NSDictionary *)dict;
- (NSDictionary *)readActiveServer;

@property (nonatomic, retain) NSArray *arrayWithServers;

@end
