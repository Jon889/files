//
//  FLRZipInternalDirectory.h
//  Filer
//
//  Created by Jonathan on 25/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRDirectory.h"

@interface FLRZipInternalDirectory : FLRDirectory
-(instancetype)initWithPath:(NSString *)path contents:(NSDictionary *)contents;
@end
