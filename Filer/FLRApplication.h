//
//  FLRApplication.h
//  Filer
//
//  Created by Jonathan on 09/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLRApplication : UIApplication
+(instancetype)sharedApplication;
@property (nonatomic, strong) NSString *currentPath;

@end
