//
//  FLRFileListViewController.m
//  Filer
//
//  Created by Jonathan on 23/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRFileListViewController.h"
#import "FLRFileSystemItem.h"
#import "FLRDirectory.h"
#import "FLRFileViewController.h"
#import "FLRFile.h"
#import "FLRDirectoryViewController.h"
#import "FLRZippedDirectory.h"
#import "FLRZipViewController.h"

@interface FLRFileListViewController () 

@end

@implementation FLRFileListViewController

-(void)setFiles:(NSArray *)files {
    _files = files;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.files.count;
}

-(NSString *)cellIdentifierForItem:(FLRFileSystemItem *)item {
    if ([item isKindOfClass:[FLRZippedDirectory class]]) {
        return @"zipCell";
    } else {
        return item.isDirectory ? @"directoryCell" : @"fileCell";
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FLRFileSystemItem *item = [self itemForIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifierForItem:item] forIndexPath:indexPath];
    cell.textLabel.text = [item name];
    return cell;
}
-(FLRFileSystemItem *)itemForIndexPath:(NSIndexPath *)indexPath {
    return [self files][indexPath.row];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return !self.tableView.isEditing;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    if ([[segue identifier] isEqualToString:@"fileDetail"]) {
        FLRFileViewController *dest = (FLRFileViewController *)segue.destinationViewController;
        [dest setCurrentFile:(FLRFile*)[self itemForIndexPath:path]];
    } else if ([[segue identifier] isEqualToString:@"directory"]) {
        FLRDirectoryViewController *dest = (FLRDirectoryViewController *)segue.destinationViewController;
        [dest setCurrentDirectory:(FLRDirectory *)[self itemForIndexPath:path]];
    } else if ([[segue identifier] isEqualToString:@"zipFile"]) {
        FLRZipViewController *dest = (FLRZipViewController *)segue.destinationViewController;
        [dest setCurrentDirectory:(FLRZippedDirectory *)[self itemForIndexPath:path]];
    }
}
@end
