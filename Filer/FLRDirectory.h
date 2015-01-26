//
//  FLRDirectory.h
//  Filer
//
//  Created by Jonathan on 04/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLRFileSystemItem.h"

NSString * const FLRDirectoryContentsChanged;

@interface FLRDirectory : FLRFileSystemItem


@property (strong, readonly, nonatomic) NSArray *contents;

-(BOOL)createNewDirectoryNamed:(NSString *)name error:(NSError **)error;
-(void)directoryChanged;
@end
