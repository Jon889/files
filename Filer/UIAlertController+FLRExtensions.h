//
//  UIAlertController+FLRExtensions.h
//  Filer
//
//  Created by Jonathan on 09/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (FLRExtensions)
+(instancetype)textfieldAlertControllerWithTitle:(NSString *)title buttonText:(NSString *)buttonText handler:(void (^)(NSString *name))handler;
+(instancetype)textfieldAlertControllerWithTitle:(NSString *)title buttonText:(NSString *)buttonText textFieldConfig:(void(^)(UITextField *))textFieldHandler handler:(void (^)(NSString *name))handler;
+(instancetype)alertControllerWithError:(NSError *)error;
@end
