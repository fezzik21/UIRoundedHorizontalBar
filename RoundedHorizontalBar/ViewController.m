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
                                           andCount:3
                                          andTitles:@[@"V1", @"V2", @"V3"]
                                            andFont:[UIFont fontWithName:@"Avenir-Book" size:15.0f]
                               andSelectedTextColor:[UIColor darkGrayColor]
                             andDeselectedTextColor:[UIColor whiteColor]
                                   andSelectedColor:[UIColor colorWithRed:160.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]
                                 andDeselectedColor:[UIColor colorWithRed:110.0/255.0 green:110.0/255.0 blue:110.0/255.0 alpha:1.0]
                                  andSeperatorColor:[UIColor colorWithRed:40.0/255.0 green:40.0/255.0 blue:50.0/255.0 alpha:1.0]
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
