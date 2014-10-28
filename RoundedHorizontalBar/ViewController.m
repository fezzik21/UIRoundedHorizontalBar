//
//  ViewController.m
//  RoundedHorizontalBar
//
//  Created by Adam Hunter on 10/27/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "ViewController.h"

#import "UIRoundedHorizontalBar.h"

@interface ViewController ()

@property (nonatomic, strong) UIRoundedHorizontalBar *bar;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.bar = [UIRoundedHorizontalBar barWithFrame:CGRectMake(20, 100, 280, 40)
                                           andCount:6
                                          andTitles:@[@"V1", @"V2", @"V3", @"V4", @"V5", @"V6"]
                                            andFont:[UIFont fontWithName:@"Avenir-Book" size:15.0f]
                                       andTextColor:[UIColor whiteColor]
                                   andSelectedColor:[UIColor lightGrayColor]
                                 andDeselectedColor:[UIColor darkGrayColor]
                                  andSeperatorColor:[UIColor whiteColor]
                                        andDelegate:self];
    [self.view addSubview:self.bar];
}

- (void)selectionChangedFrom:(int)oldValue to:(int)newValue
{
    NSLog(@"selectionChangedFrom: %d to %d", oldValue, newValue);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
