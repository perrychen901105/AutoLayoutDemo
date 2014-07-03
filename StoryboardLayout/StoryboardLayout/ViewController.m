//
//  ViewController.m
//  StoryboardLayout
//
//  Created by Perry on 14-7-2.
//  Copyright (c) 2014年 Perrychen. All rights reserved.
//

#import "ViewController.h"

@interface UIWindow (AutoLayoutDebug)

+ (UIWindow *)keyWindow;
- (NSString *)_autolayoutTrace;

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
//    NSLog(@"%@",[[UIWindow keyWindow] _autolayoutTrace]);
}

@end
