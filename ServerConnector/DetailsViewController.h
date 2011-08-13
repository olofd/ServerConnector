//
//  DetailsViewController.h
//  ServerConnector
//
//  Created by Olof Dahlbom on 2011-08-14.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController <UITableViewDataSource>
{
    NSDictionary *dictWithServerDetails;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic)NSDictionary *dictWithServerDetails;
@end
