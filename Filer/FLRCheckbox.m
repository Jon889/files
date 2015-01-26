//
//  FLRCheckbox.m
//  Pods
//
//  Created by Jonathan on 12/01/2015.
//
//

#import "FLRCheckbox.h"

@implementation FLRCheckbox

-(void)setSelected:(BOOL)selected {
    _selected = selected;
    if (selected) {
        [self setBackgroundColor:[UIColor greenColor]];
    } else {
        [self setBackgroundColor:[UIColor redColor]];
    }
}
-(void)layoutSubviews {
    [super layoutSubviews];
    [self setSelected:[self isSelected]];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setSelected:![self isSelected]];
}
@end
