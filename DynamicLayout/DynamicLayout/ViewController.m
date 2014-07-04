//
//  ViewController.m
//  DynamicLayout
//
//  Created by Perry on 14-7-4.
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
    UIButton *leftButton;
    UIButton *centerButton;
    UIButton *rightButton;
    BOOL buttonIsVisible;
    NSLayoutConstraint *centerYConstraint;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)leftButtonPressed
{
    NSLog(@"Before: constraints = %@", self.view.constraints);
    buttonIsVisible = !buttonIsVisible;
    if (buttonIsVisible) {
//        [centerButton removeFromSuperview];
        [self.view addSubview:centerButton];
        centerButton.alpha = 0.0f;
        
        NSLayoutConstraint *constraint = [NSLayoutConstraint
                                          constraintWithItem:centerButton
                                          attribute:NSLayoutAttributeCenterX
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.view
                                          attribute:NSLayoutAttributeCenterX
                                          multiplier:1.0f constant:0.0f];
        [self.view addConstraint:constraint];
        
        constraint = [NSLayoutConstraint
                      constraintWithItem:centerButton
                      attribute:NSLayoutAttributeCenterY
                      relatedBy:NSLayoutRelationEqual
                      toItem:self.view
                      attribute:NSLayoutAttributeCenterY
                      multiplier:1.0f
                      constant:0.0f];
        [self.view addConstraint:constraint];
        [self.view layoutIfNeeded];
    }
//    else {
//        [self.view addSubview:centerButton];
//    }
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3f animations:^{
        [self.view layoutIfNeeded];
        centerButton.alpha = buttonIsVisible ? 1.0f : 0.0f;
    }
     completion:^(BOOL finished) {
         if (!buttonIsVisible) {
             [centerButton removeFromSuperview];
         }
     }];
    NSLog(@"After: constraints = %@", self.view.constraints);
}

- (void)rightButtonPressed
{
    if (centerYConstraint.constant == 0.0f) {
        centerYConstraint.constant = 100.0f;
    } else {
        centerYConstraint.constant *= -1.0f;
    }
    [UIView animateWithDuration:0.5f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [leftButton setTitle:@"Left" forState:UIControlStateNormal];
    [self.view addSubview:leftButton];
    
    centerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    centerButton.translatesAutoresizingMaskIntoConstraints = NO;
    [centerButton setTitle:@"Center" forState:UIControlStateNormal];
    [self.view addSubview:centerButton];
    
    rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [rightButton setTitle:@"Right" forState:UIControlStateNormal];
    [self.view addSubview:rightButton];
    
    buttonIsVisible = YES;
    
    /*
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem:centerButton
                                      attribute:NSLayoutAttributeCenterX
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                      attribute:NSLayoutAttributeCenterX
                                      multiplier:1.0f
                                      constant:0.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint
                  constraintWithItem:centerButton
                  attribute:NSLayoutAttributeCenterY
                  relatedBy:NSLayoutRelationEqual
                  toItem:self.view
                  attribute:NSLayoutAttributeCenterY
                  multiplier:1.0f constant:0.0f];
    [self.view addConstraint:constraint];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(leftButton,centerButton,rightButton);
    NSArray *constraints = [NSLayoutConstraint
                            constraintsWithVisualFormat:@"[leftButton]-[centerButton]-[rightButton]"
                            options:NSLayoutFormatAlignAllBaseline
                            metrics:nil
                            views:viewsDictionary];
    [self.view addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nextButton]-distance-|" options:0
                                                          metrics:@{ @"distance": @50 }
                                                            views:viewsDictionary];
//    [self.view removeConstraints:self.view.constraints];
    */
    [self.view setNeedsUpdateConstraints];
    [leftButton addTarget:self
                   action:@selector(leftButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton addTarget:self
                    action:@selector(rightButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
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

- (void)updateViewConstraints
{
    NSLog(@"%s",__func__);
    [super updateViewConstraints];
    
    [self.view removeConstraints:self.view.constraints];
    
    if (buttonIsVisible) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint
                                          constraintWithItem:centerButton
                                          attribute:NSLayoutAttributeCenterX
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.view
                                          attribute:NSLayoutAttributeCenterX
                                          multiplier:1.0f
                                          constant:0.0f];
        [self.view addConstraint:constraint];
        
        constraint = [NSLayoutConstraint
                      constraintWithItem:centerButton
                      attribute:NSLayoutAttributeCenterY
                      relatedBy:NSLayoutRelationEqual
                      toItem:self.view
                      attribute:NSLayoutAttributeCenterY
                      multiplier:1.0f constant:0.0f];
        
        centerYConstraint = constraint;
        
        [self.view addConstraint:constraint];
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(leftButton,centerButton,rightButton);
        NSArray *constraints = [NSLayoutConstraint
                                constraintsWithVisualFormat:@"[leftButton]-[centerButton]-[rightButton]"
                                options:NSLayoutFormatAlignAllBaseline
                                metrics:nil
                                views:viewsDictionary];
        [self.view addConstraints:constraints];
    } else {
        NSLayoutConstraint *constraint = [NSLayoutConstraint
                                          constraintWithItem:leftButton
                                          attribute:NSLayoutAttributeTrailing
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.view
                                          attribute:NSLayoutAttributeCenterX
                                          multiplier:1.0f
                                          constant:-10.0f];
        [self.view addConstraint:constraint];
        
        constraint = [NSLayoutConstraint
                      constraintWithItem:leftButton
                      attribute:NSLayoutAttributeCenterY
                      relatedBy:NSLayoutRelationEqual
                      toItem:self.view
                      attribute:NSLayoutAttributeCenterY
                      multiplier:1.0f constant:0.0f];
        [self.view addConstraint:constraint];
        
        constraint = [NSLayoutConstraint
                      constraintWithItem:rightButton
                      attribute:NSLayoutAttributeLeading
                      relatedBy:NSLayoutRelationEqual
                      toItem:self.view
                      attribute:NSLayoutAttributeCenterX
                      multiplier:1.0f constant:10.0f];
        [self.view addConstraint:constraint];
        
        constraint = [NSLayoutConstraint
                      constraintWithItem:rightButton
                      attribute:NSLayoutAttributeCenterY
                      relatedBy:NSLayoutRelationEqual
                      toItem:self.view
                      attribute:NSLayoutAttributeCenterY
                      multiplier:1.0f constant:0.0f];
        [self.view addConstraint:constraint];
        
        centerYConstraint = nil;
    }
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
