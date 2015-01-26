//
//  FLRFileListViewController.h
//  Filer
//
//  Created by Jonathan on 23/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLRFileListViewController : UIViewController <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *files; //FLRFileSystemItems
@end
