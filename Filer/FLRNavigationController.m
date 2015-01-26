//
//  FLRNavigationController.m
//  Filer
//
//  Created by Jonathan on 08/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRNavigationController.h"
#import "FLRDirectoryViewController.h"
#import "FLRDirectory.h"
#import "UINavigationBar+Private.h"
#import "FLRGoToViewController.h"
#import "FLRSettingsManager.h"
#import "FLRViewController.h"

@interface FLRNavigationController () <FLRGoToViewControllerDelegate>

@end

@implementation FLRNavigationController

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([[touch view] isKindOfClass:[UINavigationBar class]]) {
        UIView *backButton = [(UINavigationBar *)[touch view] currentBackButton];
        if (backButton) {
            CGPoint point = [touch locationInView:backButton];
            if (CGRectContainsPoint(backButton.bounds, point)) {
                return NO;
            }
        }
    }
    return YES;
}
-(void)viewDidLoad {
    [super viewDidLoad];
    [self goToPath:[[FLRSettingsManager sharedInstance] homePath]];
}
-(void)goToPath:(NSString *)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSArray *pathComponents = [path pathComponents];
        NSString *pathToNow = @"";
        NSMutableArray *vcs = [NSMutableArray array];
        for (NSString *component in pathComponents) {
            pathToNow = [pathToNow stringByAppendingPathComponent:component];
            FLRDirectoryViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FLRDirectoryViewController"];
            [vc setCurrentDirectory:[[FLRDirectory alloc] initWithPath:pathToNow]];
            [vcs addObject:vc];
        }
        [self setViewControllers:vcs animated:YES];
    }

}
-(void)goToViewControllerCancelled {
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)goToViewControllerEnteredPath:(NSString *)path {
    [self dismissViewControllerAnimated:NO completion:^{
        [self goToPath:path];
    }];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[FLRGoToViewController class]]) {
        [(FLRGoToViewController *)segue.destinationViewController setDelegate:self];
    }
}
//-(void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
//    for (UIViewController *vc in viewControllers) {
//        NSAssert([vc isKindOfClass:[FLRViewController class]], @"View Controller must be FLRViewController subclass");
//    }
//    [super setViewControllers:viewControllers animated:animated];
//}
//
//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    NSAssert([viewController isKindOfClass:[FLRViewController class]], @"View Controller must be FLRViewController subclass");
//    [super pushViewController:viewController animated:animated];
//}
//-(NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    NSAssert([viewController isKindOfClass:[FLRViewController class]], @"View Controller must be FLRViewController subclass");
//    return [super popToViewController:viewController animated:animated];
//}
@end
