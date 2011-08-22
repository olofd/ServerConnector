//
//  DataParser.h
//  SteenX
//
//  Created by Olof Dahlbom on 2011-07-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJsonParser.h"
#import "PlistServerController.h"

@interface DataParser : NSObject{

    SBJsonParser *parser;
    PlistServerController *plistController;
}

@property (nonatomic, retain) SBJsonParser *parser;



-(BOOL)loginOnServer:(NSDictionary *)dict withUsername:(NSString *)userName andPassword:(NSString *)password;

- (BOOL)testServerWithDictionary:(NSDictionary *)dict;

@property (strong, nonatomic) PlistServerController *plistController;

@end
