//
//  FLRHTTPConnection.m
//  Filer
//
//  Created by Jonathan on 06/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRHTTPConnection.h"
#import <HTTPDynamicFileResponse.h>
#import <HTTPFileResponse.h>
#import "FLRDirectory.h"


@implementation FLRHTTPConnection

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
    
    BOOL isDir;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir] && !isDir) {
        return [[HTTPFileResponse alloc] initWithFilePath:path forConnection:self];
    }
    
    FLRDirectory *dir = [[FLRDirectory alloc] initWithPath:path];
    
    NSMutableString *listing = [NSMutableString string];
    for (FLRFileSystemItem *item in dir.contents) {
        [listing appendFormat:@"%@<a href='%@'>%@</a>%@</br>", item.isDirectory ? @"<b>" : @"", item.path, item.name, item.isDirectory ? @"</b>" : @""];
    }
    
        return [[HTTPDynamicFileResponse alloc] initWithFilePath:[self filePathForURI:@"index.html"]
                                                   forConnection:self
                                                       separator:@"%%"
                                           replacementDictionary:@{@"files" : listing}];
}


@end
