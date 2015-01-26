//
//  FLRDirectoryViewController.h
//  Filer
//
//  Created by Jonathan on 04/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLRTopToolbarViewController.h"

@class FLRDirectory;
@interface FLRDirectoryViewController : FLRTopToolbarViewController
- (IBAction)add:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutletCollection(UIBarButtonItem) NSArray *standardToolbarItems;
@property (strong, nonatomic) IBOutletCollection(UIBarButtonItem) NSArray *editingToolbarItems;
- (IBAction)compress:(UIBarButtonItem *)sender;
- (IBAction)share:(UIBarButtonItem *)sender;
@property (nonatomic, strong) FLRDirectory *currentDirectory;
- (IBAction)rename:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *compressButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *renameButton;
- (IBAction)goHome:(UIBarButtonItem *)sender;

@end
