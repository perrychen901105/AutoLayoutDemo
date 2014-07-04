//
//  ViewController.m
//  CodeConstraints
//
//  Created by Perry on 14-7-3.
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
{
    UIButton *button1;
    UIButton *button2;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setTitle:@"Button 1" forState:UIControlStateNormal];
    [button1 sizeToFit];
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button1];
    
    
    button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.translatesAutoresizingMaskIntoConstraints = NO;
    [button2 setTitle:@"Button 2" forState:UIControlStateNormal];
    [self.view addSubview:button2];
    
//    NSLayoutConstraint *constraint = [NSLayoutConstraint
//                                      constraintWithItem:button1
//                                      attribute:NSLayoutAttributeRight
//                                      relatedBy:NSLayoutRelationEqual
//                                      toItem:self.view
//                                      attribute:NSLayoutAttributeRight
//                                      multiplier:1.0f constant:-20.0f];
//    [self.view addConstraint:constraint];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                  constraintWithItem:button1
                  attribute:NSLayoutAttributeBottom
                  relatedBy:NSLayoutRelationEqual toItem:self.view
                  attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-20.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint
                  constraintWithItem:button1
                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual
                  toItem:self.view attribute:NSLayoutAttributeCenterX
                  multiplier:1.0f constant:0.0f];
    [self.view addConstraint:constraint];
   
    /*
    // instrnic content size
    constraint = [NSLayoutConstraint
                  constraintWithItem:button1
                  attribute:NSLayoutAttributeWidth
                  relatedBy:NSLayoutRelationEqual
                  toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                  multiplier:1.0f constant:200.0f];
    [self.view addConstraint:constraint];
     */
    
//    constraint = [NSLayoutConstraint
//                  constraintWithItem:button1
//                  attribute:NSLayoutAttributeWidth
//                  relatedBy:NSLayoutRelationGreaterThanOrEqual
//                  toItem:nil attribute:NSLayoutAttributeNotAnAttribute
//                  multiplier:1.0f constant:200.0f];
//    [button1 addConstraint:constraint];
    
    // set the width
    constraint = [NSLayoutConstraint
                  constraintWithItem:button1
                  attribute:NSLayoutAttributeWidth
                  relatedBy:NSLayoutRelationLessThanOrEqual
                  toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                  multiplier:1.0f constant:300.0f];
    [button1 addConstraint:constraint];
    
    // align the leading
    constraint = [NSLayoutConstraint
                  constraintWithItem:button1
                  attribute:NSLayoutAttributeLeading
                  relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.view
                  attribute:NSLayoutAttributeLeading
                  multiplier:1.0f
                  constant:60.0f];
    [self.view addConstraint:constraint];
    
    // align the trailing
    constraint = [NSLayoutConstraint
                  constraintWithItem:button1
                  attribute:NSLayoutAttributeTrailing
                  relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.view
                  attribute:NSLayoutAttributeTrailing
                  multiplier:1.0f
                  constant:-60.0f];
    [self.view addConstraint:constraint];
    
    // width is euqal to 300, priority is 999
    constraint = [NSLayoutConstraint
                  constraintWithItem:button1
                  attribute:NSLayoutAttributeWidth
                  relatedBy:NSLayoutRelationEqual
                  toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                  multiplier:1.0f constant:300.0f];
    [self.view addConstraint:constraint];
    
    constraint.priority = 999;
    [button1 addConstraint:constraint];
    
    // height is equal to half of width
    constraint = [NSLayoutConstraint
                  constraintWithItem:button1
                  attribute:NSLayoutAttributeHeight
                  relatedBy:NSLayoutRelationEqual
                  toItem:button1
                  attribute:NSLayoutAttributeWidth
                  multiplier:0.5f constant:0.0f];
    [button1 addConstraint:constraint];
    
    // height less than or equal 260 ,priority is 998
    constraint = [NSLayoutConstraint
                  constraintWithItem:button1
                  attribute:NSLayoutAttributeHeight
                  relatedBy:NSLayoutRelationLessThanOrEqual
                  toItem:nil
                  attribute:NSLayoutAttributeNotAnAttribute
                  multiplier:1.0f constant:260.0f];
    constraint.priority = 998;
    [button1 addConstraint:constraint];
    
    // set button 2 bottom align the button1 top
    constraint = [NSLayoutConstraint
                  constraintWithItem:button2
                  attribute:NSLayoutAttributeBottom
                  relatedBy:NSLayoutRelationEqual
                  toItem:button1
                  attribute:NSLayoutAttributeTop
                  multiplier:1.0f
                  constant:-8.0f];
    [self.view addConstraint:constraint];
    
    
    // set button2 left align the button1 left
    constraint = [NSLayoutConstraint
                  constraintWithItem:button2
                  attribute:NSLayoutAttributeLeading
                  relatedBy:NSLayoutRelationEqual
                  toItem:button1
                  attribute:NSLayoutAttributeLeading
                  multiplier:1.0f
                  constant:0.0f];
    [self.view addConstraint:constraint];
    
    
    
    [button1 addTarget:button1 action:@selector(exerciseAmbiguityInLayout) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@",[[UIWindow keyWindow] _autolayoutTrace]);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    NSLog(@"%@",[[UIWindow keyWindow] _autolayoutTrace]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
