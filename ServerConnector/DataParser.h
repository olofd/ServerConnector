//
//  DataParser.h
//  SteenX
//
//  Created by Olof Dahlbom on 2011-07-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJsonParser.h"

@interface DataParser : NSObject{

    SBJsonParser *parser;
}

@property (nonatomic, retain) SBJsonParser *parser;


-(NSArray *)loginWithUsername:(NSString *)user AndPassword:(NSString *)password;
- (BOOL)testServerWithDictionary:(NSDictionary *)dict;

@end
