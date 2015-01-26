//
//  FLRApplication.m
//  Filer
//
//  Created by Jonathan on 09/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRApplication.h"

@implementation FLRApplication
+(instancetype)sharedApplication {
    return (FLRApplication *)[UIApplication sharedApplication];
}
@end
