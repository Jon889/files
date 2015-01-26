//
//  FLRGoToViewController.h
//  Filer
//
//  Created by Jonathan on 09/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FLRGoToViewControllerDelegate <NSObject>
-(void)goToViewControllerEnteredPath:(NSString *)string;
-(void)goToViewControllerCancelled;
@end

@interface FLRGoToViewController : UIViewController <UINavigationBarDelegate>
@property (nonatomic, weak) IBOutlet id<FLRGoToViewControllerDelegate> delegate;
@end
