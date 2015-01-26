//
//  FLRCheckbox.h
//  Pods
//
//  Created by Jonathan on 12/01/2015.
//
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface FLRCheckbox : UIView
@property(nonatomic, getter=isSelected) IBInspectable BOOL selected;
@end
