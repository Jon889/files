//
//  FLRSettingsManager.h
//  Filer
//
//  Created by Jonathan on 26/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLRSettingsManager : NSObject
+(instancetype)sharedInstance;
@property (nonatomic, strong) NSString *homePath;
@end
