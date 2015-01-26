//
//  FLRWebServer.m
//  Filer
//
//  Created by Jonathan on 05/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRWebServer.h"
#import <CocoaHTTPServer/HTTPServer.h>
#import "FLRHTTPConnection.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@interface FLRWebServer ()
@property (nonatomic, strong) HTTPServer *server;

@end

@implementation FLRWebServer
static FLRWebServer *sharedInstance;
+(instancetype)sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[FLRWebServer alloc] _init];
        [sharedInstance start];
    }
    return sharedInstance;
}
-(instancetype)init {
    return nil;
}
-(instancetype)_init {
    if (self = [super init]) {
        HTTPServer *server = [[HTTPServer alloc] init];
        [server setConnectionClass:[FLRHTTPConnection class]];
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
        [server setType:@"_http._tcp."];
        [server setDocumentRoot:path];
        [server setName:@"Filer"];
        [server setPort:1234];
        self.server = server;
    }
    return self;
}
-(void)start {
    [self.server start:nil];
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"co.uk.jonathanb.filer"];
    NSString *address = [NSString stringWithFormat:@"http://%@:%i%@", [self getIPAddress], self.server.listeningPort, self.currentPath ?: @""];
    [activity setWebpageURL:[NSURL URLWithString:address]];
    [activity becomeCurrent];
    [[UIApplication sharedApplication] setUserActivity:activity];
}
-(void)setCurrentPath:(NSString *)currentPath {
    _currentPath = currentPath;
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"co.uk.jonathanb.filer"];
    NSString *address = [NSString stringWithFormat:@"http://%@:%i%@", [self getIPAddress], self.server.listeningPort, self.currentPath ?: @""];
    [activity setWebpageURL:[NSURL URLWithString:address]];
    [activity becomeCurrent];
    [[UIApplication sharedApplication] setUserActivity:activity];
}
-(void)stop {
    [self.server stop];
}

- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}
@end
