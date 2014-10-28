//
//  UIRoundedHorizontalBar.h
//  RoundedHorizontalBar
//
//  Created by Adam Hunter on 10/27/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIRoundedHorizontalBarDelegate.h"

@interface UIRoundedHorizontalBar : UIView

+ (UIRoundedHorizontalBar *)barWithFrame:(CGRect)frame
                                andCount:(int)count
                               andTitles:(NSArray *)titles
                                 andFont:(UIFont *)font
                            andTextColor:(UIColor *)textColor
                        andSelectedColor:(UIColor *)selectedColor
                      andDeselectedColor:(UIColor *)deselectedColor
                       andSeperatorColor:(UIColor *)seperatorColor
                             andDelegate:(NSObject<UIRoundedHorizontalBarDelegate> *)delegate;

@end
