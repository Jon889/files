//
//  FLRZipInternalDirectory.m
//  Filer
//
//  Created by Jonathan on 25/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRZipInternalDirectory.h"
#import "FLRDirectory+Private.h"

@interface FLRZipInternalDirectory ()
@property (nonatomic, strong) NSDictionary *contentsDict;
@end

@implementation FLRZipInternalDirectory
-(instancetype)initWithPath:(NSString *)path contents:(NSDictionary *)contents {
    if (self = [super initWithPath:path]) {
        self.contentsDict = contents;
    }
    return self;
}
-(void)loadContents {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in [self.contentsDict allKeys]) {
        [array addObject:[[FLRZipInternalDirectory alloc] initWithPath:[self.path stringByAppendingPathComponent:key] contents:self.contentsDict[key]]];
    }
    self.contents = array;
}
@end
