//
//  UIBarButtonItem+autorelease.m
//  CastAllDev
//
//  Created by Jonathan on 31/05/2014.
//  Copyright (c) 2014 Jonathan. All rights reserved.
//

#import "UIBarButtonItem+autorelease.h"

@implementation UIBarButtonItem (autorelease)

+(instancetype)barButtonItemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    return [[[self class] alloc] initWithImage:image style:style target:target action:action];
}
+(instancetype)barButtonItemWithCustomView:(UIView *)view {
    return [[[self class] alloc] initWithCustomView:view];
}
+(instancetype)barButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    return [[[self class] alloc] initWithTitle:title style:style target:target action:action];
}
+(instancetype)barButtonSystemItem:(UIBarButtonSystemItem)si target:(id)target action:(SEL)action {
    return [[[self class] alloc] initWithBarButtonSystemItem:si target:target action:action];
}
+(instancetype)flexibleSpace {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}
@end