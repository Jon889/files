//
//  FLRFileSystemItem.h
//  
//
//  Created by Jonathan on 04/01/2015.
//
//

#import <Foundation/Foundation.h>

@interface FLRFileSystemItem : NSObject
@property (strong, readonly) NSString *path;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) BOOL isDirectory;
-(instancetype)initWithPath:(NSString *)path;
-(void)rename:(NSString *)newName;

@end
