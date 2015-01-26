//
//  UITableView+FLRExtensions.h
//  Filer
//
//  Created by Jonathan on 23/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (FLRExtensions)
-(void)selectAllRowsInSection:(NSInteger)section;
-(void)invertSelectionInSection:(NSInteger)section;
@end
