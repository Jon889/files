//
//  FLRTopToolbarViewController.m
//  Filer
//
//  Created by Jonathan on 23/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "FLRTopToolbarViewController.h"
#import "UINavigationBar+Private.h"

@interface FLRTopToolbarViewController () <UIToolbarDelegate>

@end

@implementation FLRTopToolbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topToolbar = [[UIToolbar alloc] init];
    
    [self.topToolbar setFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, 0)];
    [self.topToolbar setDelegate:self];
    [self.view addSubview:self.topToolbar];
    [self.topToolbar.superview bringSubviewToFront:self.topToolbar];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar _setHidesShadow:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar _setHidesShadow:NO];
    [super viewWillDisappear:animated];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.topToolbar setFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, self.topToolbar.frame.size.height)];
}

-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIToolbarPositionTop;
}

-(void)setTopToolbarHidden:(BOOL)hidden {
    if (!hidden) {
        [self.topToolbar setItems:nil animated:YES];
    }
    CGFloat topToolbarHeight = 25;
    [self.topToolbar setItems:self.topToolbarItems animated:YES];
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frm = self.topToolbar.frame;
        frm.size.height = !hidden ? topToolbarHeight : 0;
        self.topToolbar.frame = frm;
    }];
}

@end
