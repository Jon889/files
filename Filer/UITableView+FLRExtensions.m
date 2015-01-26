//
//  UITableView+FLRExtensions.m
//  Filer
//
//  Created by Jonathan on 23/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "UITableView+FLRExtensions.h"

@implementation UITableView (FLRExtensions)
-(void)selectAllRowsInSection:(NSInteger)section {
    for (int i = 0; i < [self numberOfRowsInSection:section]; i++) {
        [self selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}
-(void)invertSelectionInSection:(NSInteger)section {
    for (int i = 0; i < [self numberOfRowsInSection:section]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        if ([[self indexPathsForSelectedRows] containsObject:indexPath]) {
            [self deselectRowAtIndexPath:indexPath animated:YES];
        } else {
            [self selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    }
}
@end
