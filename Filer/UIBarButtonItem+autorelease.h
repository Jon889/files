//
//  UIBarButtonItem+autorelease.h
//  CastAllDev
//
//  Created by Jonathan on 31/05/2014.
//  Copyright (c) 2014 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (autorelease)
+(instancetype)barButtonItemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action;
+(instancetype)barButtonItemWithCustomView:(UIView *)view;
+(instancetype)barButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action;
+(instancetype)barButtonSystemItem:(UIBarButtonSystemItem)si target:(id)target action:(SEL)action;
+(instancetype)flexibleSpace;
@end
