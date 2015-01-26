//
//  FLRWebServer.h
//  Filer
//
//  Created by Jonathan on 05/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLRWebServer : NSObject
@property (nonatomic, strong) NSString *currentPath;
+(instancetype)sharedInstance;
-(void)start;
@end
