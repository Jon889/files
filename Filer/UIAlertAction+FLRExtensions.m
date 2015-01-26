//
//  UIAlertAction+FLRExtensions.m
//  Filer
//
//  Created by Jonathan on 09/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "UIAlertAction+FLRExtensions.h"

@implementation UIAlertAction (FLRExtensions)

+(instancetype)cancelAction {
    return [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
}

@end
