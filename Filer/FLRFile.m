//
//  FLRFile.m
//  Filer
//
//  Created by Jonathan on 04/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRFile.h"
#import "FLRDirectory+Private.h"

@implementation FLRFile
-(instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        [self setPath:path];
    }
    return self;
}
-(BOOL)isDirectory {
    return NO;
}
@end
