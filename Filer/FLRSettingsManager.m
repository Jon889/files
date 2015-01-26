//
//  FLRSettingsManager.m
//  Filer
//
//  Created by Jonathan on 26/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRSettingsManager.h"

@implementation FLRSettingsManager
static FLRSettingsManager *_sharedInstance;
+(instancetype)sharedInstance {
    if (!_sharedInstance) {
        _sharedInstance = [[FLRSettingsManager alloc] _init];
    }
    return _sharedInstance;
}
-(instancetype)_init {
    return [super init];
}
-(instancetype)init {
    return nil;
}

-(NSString *)homePath {
    return @"/tmp";
}

@end
