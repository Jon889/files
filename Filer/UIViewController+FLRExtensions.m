//
//  UIViewController+FLRExtensions.m
//  Filer
//
//  Created by Jonathan on 09/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "UIViewController+FLRExtensions.h"

@implementation UIViewController (FLRExtensions)

-(void)presentViewController:(UIViewController *)viewControllerToPresent {
    [self presentViewController:viewControllerToPresent animated:YES completion:nil];
}

@end
