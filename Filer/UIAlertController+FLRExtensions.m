//
//  UIAlertController+FLRExtensions.m
//  Filer
//
//  Created by Jonathan on 09/01/2015.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

#import "UIAlertController+FLRExtensions.h"

@implementation UIAlertController (FLRExtensions)
+(instancetype)textfieldAlertControllerWithTitle:(NSString *)title buttonText:(NSString *)buttonText handler:(void (^)(NSString *name))handler {
    return [self textfieldAlertControllerWithTitle:title buttonText:buttonText textFieldConfig:nil handler:handler];
}
+(instancetype)textfieldAlertControllerWithTitle:(NSString *)title buttonText:(NSString *)buttonText textFieldConfig:(void(^)(UITextField *))textFieldHandler handler:(void (^)(NSString *name))handler {
    UIAlertController *nameAlertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [nameAlertController addTextFieldWithConfigurationHandler:textFieldHandler];
    [nameAlertController addAction:[UIAlertAction actionWithTitle:buttonText style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *folderName = [[nameAlertController textFields][0] text];
        if (handler) {
            handler(folderName);
        }
    }]];
    [nameAlertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    return nameAlertController;
}

+(instancetype)alertControllerWithError:(NSError *)error {
    UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:@"Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    [errorAlertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    return errorAlertController;
}
@end
