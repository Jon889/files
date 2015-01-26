//
//  FLRFileSystemItem.m
//  
//
//  Created by Jonathan on 04/01/2015.
//
//

#import "FLRFileSystemItem+Private.h"

@implementation FLRFileSystemItem
-(instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        [self setPath:path];
    }
    return self;
}

-(NSString *)name {
    return self.path.lastPathComponent;
}

-(void)rename:(NSString *)newName {
    NSString *newPath = [[self.path stringByDeletingLastPathComponent] stringByAppendingPathComponent:newName];
    [[NSFileManager defaultManager] moveItemAtPath:self.path toPath:newPath error:nil];
}
@end
