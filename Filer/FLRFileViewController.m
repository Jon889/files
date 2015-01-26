//
//  FLRFileViewController.m
//  Filer
//
//  Created by Jonathan on 11/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRFileViewController.h"
#import "FLRCheckbox.h"

@implementation FLRFileViewController
-(NSString *)title {
    return [self.currentFile name];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pathCell" forIndexPath:indexPath];
    UIView *view = [[FLRCheckbox alloc] init];
    [view setFrame:CGRectMake(60, 0, 47, 44)];
    [cell addSubview:view];
    return cell;
}
@end
