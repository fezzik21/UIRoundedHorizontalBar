//
//  UIRoundedHorizontalBar.m
//  RoundedHorizontalBar
//
//  Created by Adam Hunter on 10/27/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "UIRoundedHorizontalBar.h"

@interface UIRoundedHorizontalBar ()

@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) int selected;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *deselectedColor;
@property (nonatomic, strong) NSObject<UIRoundedHorizontalBarDelegate> *delegate;

@end

@implementation UIRoundedHorizontalBar

#define SEPERATOR_WIDTH 1

+ (UIRoundedHorizontalBar *)barWithFrame:(CGRect)frame
                                andCount:(int)count
                               andTitles:(NSArray *)titles
                                 andFont:(UIFont *)font
                            andTextColor:(UIColor *)textColor
                        andSelectedColor:(UIColor *)selectedColor
                      andDeselectedColor:(UIColor *)deselectedColor
                       andSeperatorColor:(UIColor *)seperatorColor
                             andDelegate:(NSObject<UIRoundedHorizontalBarDelegate> *)delegate
{
    UIRoundedHorizontalBar *result = [[UIRoundedHorizontalBar alloc] initWithFrame:frame
                                                                          andCount:count
                                                                         andTitles:titles
                                                                           andFont:font
                                                                      andTextColor:textColor
                                                                  andSelectedColor:selectedColor
                                                                andDeselectedColor:deselectedColor
                                                                 andSeperatorColor:seperatorColor
                                                                       andDelegate:delegate];
    return result;
}

- (UIRoundedHorizontalBar *)initWithFrame:(CGRect)frame
                                 andCount:(int)count
                                andTitles:(NSArray *)titles
                                  andFont:(UIFont *)font
                             andTextColor:(UIColor *)textColor
                         andSelectedColor:(UIColor *)selectedColor
                       andDeselectedColor:(UIColor *)deselectedColor
                        andSeperatorColor:(UIColor *)seperatorColor
                              andDelegate:(NSObject<UIRoundedHorizontalBarDelegate> *)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttons = [NSMutableArray arrayWithCapacity:count];
        for (int i = 0; i < count; ++i) {
            UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [newButton setFrame: CGRectMake((frame.size.width / count) * i,
                                         0,
                                         frame.size.width / count,
                                         frame.size.height)];
            [newButton setTitleColor:textColor forState:UIControlStateNormal];
            [newButton setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            [newButton setBackgroundColor:(i == 0 ? selectedColor : deselectedColor)];
            newButton.enabled = YES;
            newButton.adjustsImageWhenHighlighted = NO;
            [newButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:newButton];
            [(NSMutableArray *)self.buttons addObject:newButton];
            if (i == 0) {
                [self makeButton:newButton beEndCapOfTypeLeft:YES withColor:selectedColor];
            } else if (i == count - 1) {
                [self makeButton:newButton beEndCapOfTypeLeft:NO withColor:deselectedColor];
            }
            
            //Create a seperator
            if (i != (count - 1)) {
                UIView *seperatorView = [[UIView alloc] initWithFrame:CGRectMake(((frame.size.width / count) * (i + 1) - SEPERATOR_WIDTH), 0, 1, frame.size.height)];
                [seperatorView setBackgroundColor:seperatorColor];
                seperatorView.userInteractionEnabled = NO;
                [self addSubview:seperatorView];
            }
        }
        self.deselectedColor = deselectedColor;
        self.selectedColor = selectedColor;
        self.count = count;
        [self setClipsToBounds:YES];
        self.selected = 0;
        self.delegate = delegate;
    }
    return self;
}

- (void)makeButton:(UIButton *)button beEndCapOfTypeLeft:(BOOL)isLeft withColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(button.frame.size.width,
                                                      button.frame.size.height), NO, 1.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    CGRect rect;
    if (isLeft) {
        rect = CGRectMake(0, 0, button.frame.size.height, button.frame.size.height);
    } else {
        rect = CGRectMake(button.frame.size.width - button.frame.size.height, 0, button.frame.size.height, button.frame.size.height);
    }
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillEllipseInRect(ctx, rect);
    
    CGRect rect2;
    if (isLeft) {
        rect2 = CGRectMake(button.frame.size.height / 2, 0, button.frame.size.width - button.frame.size.height / 2, button.frame.size.height);
    } else {
        rect2 = CGRectMake(0, 0, button.frame.size.width - button.frame.size.height / 2, button.frame.size.height);
    }
    CGContextFillRect(ctx, rect2);
    
    CGContextRestoreGState(ctx);
    [button setBackgroundColor:[UIColor clearColor]];
    [button setBackgroundImage:UIGraphicsGetImageFromCurrentImageContext() forState:UIControlStateNormal];
    UIGraphicsEndImageContext();
}

- (void)buttonSelected:(id)sender
{
    for (int i = 0; i < self.count; ++i) {
        if([self.buttons objectAtIndex:i] == sender) {
            if (i != self.selected) {
                //Select button i
                UIButton *b = (UIButton*)sender;
                UIButton *oldB = (UIButton *)[self.buttons objectAtIndex:self.selected];
                if (self.selected == 0) {
                    [self makeButton:oldB beEndCapOfTypeLeft:YES withColor:self.deselectedColor];
                } else if (self.selected == (self.count - 1)) {
                    [self makeButton:oldB beEndCapOfTypeLeft:NO withColor:self.deselectedColor];
                } else {
                    [oldB setBackgroundColor:self.deselectedColor];
                }
                if (i == 0) {
                    [self makeButton:b beEndCapOfTypeLeft:YES withColor:self.selectedColor];
                } else if (i == (self.count - 1)) {
                    [self makeButton:b beEndCapOfTypeLeft:NO withColor:self.selectedColor];
                } else {
                    [b setBackgroundColor:self.selectedColor];
                }
                [self.delegate selectionChangedFrom:self.selected to:i];
                self.selected = i;
                return;
            }
        }
    }
}


@end
