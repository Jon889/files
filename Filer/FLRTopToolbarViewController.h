//
//  FLRTopToolbarViewController.h
//  Filer
//
//  Created by Jonathan on 23/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLRTopToolbarViewController : UIViewController
@property (nonatomic, strong) UIToolbar *topToolbar;
@property (nonatomic, strong) NSArray *topToolbarItems;
@property (nonatomic) CGFloat topToolbarHeight;
-(void)setTopToolbarHidden:(BOOL)hidden;
@end
