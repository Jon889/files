//
//  FLRFileViewController.h
//  Filer
//
//  Created by Jonathan on 11/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLRFile.h"

@interface FLRFileViewController : UIViewController <UITableViewDataSource>
@property (nonatomic, strong) FLRFile *currentFile;
@end
