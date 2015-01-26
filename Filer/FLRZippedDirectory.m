//
//  FLRZippedDirectory.m
//  Filer
//
//  Created by Jonathan on 23/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRZippedDirectory.h"
#import "FLRDirectory+Private.h"
#import <ZipArchive/ZipArchive.h>
#import "FLRFile.h"
#import "FLRZipInternalDirectory.h"

@interface NSArray (map)
-(NSArray*)map:(id(^)(id elem))fn;
@end

@implementation NSArray (map)

-(NSArray*)map:(id(^)(id elem))fn {
    NSMutableArray *collector = [NSMutableArray array];
    for (id obj in self) {
        [collector addObject:fn(obj)];
    }
    return collector;
}

@end

@implementation FLRZippedDirectory
-(void)loadContents {
    self.contents = nil;
}
-(NSArray *)contents {
    ZipArchive *archive = [[ZipArchive alloc] initWithFileManager:[NSFileManager defaultManager]];
    [archive UnzipOpenFile:self.path];
    NSArray *paths = [archive getZipFileContents];
    NSArray *pathsC = [paths valueForKey:@"pathComponents"];
    NSMutableArray *endPointsOnly = [NSMutableArray array];
    for (NSArray *pathC in pathsC) {
        BOOL isSubset = NO;
        for (NSArray *cmp in pathsC) {
            if ([self array:pathC isSubsetOf:cmp]) {
                isSubset = YES;
                break;
            }
        }
        if (!isSubset) {
            [endPointsOnly addObject:pathC];
        }
    }
    NSDictionary *dict = [self merge:endPointsOnly];
    return [[dict allKeys] map:^id(NSString *key) {
        return [[FLRZipInternalDirectory alloc] initWithPath:[self.path stringByAppendingPathComponent:key] contents:dict[key]];
    }];
}
-(NSDictionary *)merge:(NSArray *)array {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSArray *path in array) {
        if ([path count] > 0) {
            NSMutableArray *array = [result objectForKey:path[0]];
            if (!array) {
                array = [NSMutableArray array];
                result[path[0]] = array;
            }
            [array addObject:[path subarrayWithRange:NSMakeRange(1, [path count]-1)]];
        }
    }
    for (NSString *key in [result allKeys]) {
        result[key] = [self merge:result[key]];
    }
    return  result;
}
-(BOOL)array:(NSArray *)sub isSubsetOf:(NSArray *)sup {
    if ([sub count] < [sup count]) {
        for (int i = 0; i < [sub count]; i++) {
            if (![sub[i] isEqualToString:sup[i]]) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}
@end
