//
//  UIHorizontalRoundedBarDelegate.h
//  RoundedHorizontalBar
//
//  Created by Adam Hunter on 10/27/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIRoundedHorizontalBarDelegate <NSObject>

- (void)selectionChangedFrom:(int)oldValue to:(int)newValue;

@end
