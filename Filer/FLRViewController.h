//
//  FLRViewController.h
//  Filer
//
//  Created by Jonathan on 26/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLRNavigationController.h"

@interface UIViewController (FLRNavigationController)
@property(nonatomic,readonly,retain) FLRNavigationController *navigationController;
@end
