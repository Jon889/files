//
//  FLRDirectory.m
//  Filer
//
//  Created by Jonathan on 04/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRDirectory.h"
#import "FLRFile.h"
#import "FLRFileSystemItem+Private.h"
#import "FLRZippedDirectory.h"
#import "FLRDirectory+Private.h"

#include <dirent.h>

NSString * const FLRDirectoryContentsChanged = @"FLRDirectoryContentsChanged";


@implementation FLRDirectory
-(BOOL)createNewDirectoryNamed:(NSString *)name error:(NSError **)error {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [self.path stringByAppendingPathComponent:name];
    if ([fm createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:error]) {
        [self directoryChanged];
        return YES;
    }
    return NO;
}

-(void)loadContents {
    NSLog(@"Loading contents for %@", self.path);
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *files = [fm contentsOfDirectoryAtPath:self.path error:&error];
    NSLog(@"ERROR: %@", error);
    NSMutableArray *collector = [NSMutableArray arrayWithCapacity:files.count];
    for (NSString *file in files) {
        NSString *path = [self.path stringByAppendingPathComponent:file];
        BOOL isDir;
        
        [fm fileExistsAtPath:path isDirectory:&isDir];
        if (isDir) {
            [collector addObject:[[FLRDirectory alloc] initWithPath:path]];
        } else if ([[path pathExtension] isEqualToString:@"zip"]) {
            [collector addObject:[[FLRZippedDirectory alloc] initWithPath:path]];
        } else {
            [collector addObject:[[FLRFile alloc] initWithPath:path]];
        }
    }
    self.contents = [NSArray arrayWithArray:collector];
}

-(NSArray *)contents {
    if (!_contents) {
        [self loadContents];
    }
    return _contents;
}

-(BOOL)isDirectory {
    return YES;
}
-(void)directoryChanged {
    [self loadContents];
    [[NSNotificationCenter defaultCenter] postNotificationName:FLRDirectoryContentsChanged object:self];
}
@end
