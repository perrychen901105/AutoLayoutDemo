//
//  ViewController.m
//  SimpleCodeConstraint
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
    UIButton *deleteButton;
    UIButton *cancelButton;
    UIButton *nextButton;
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
    
    deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
    [deleteButton setTitle:@"Verwijderen" forState:UIControlStateNormal];
    [self.view addSubview:deleteButton];
    
    cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.view addSubview:cancelButton];
    
    nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextButton.translatesAutoresizingMaskIntoConstraints = NO;
    [nextButton setTitle:@"Volgende" forState:UIControlStateNormal];
    [self.view addSubview:nextButton];
    
    [deleteButton addTarget:deleteButton action:@selector(exerciseAmbiguityInLayout) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton addTarget:cancelButton action:@selector(exerciseAmbiguityInLayout) forControlEvents:UIControlEventTouchUpInside];
    [nextButton addTarget:nextButton action:@selector(exerciseAmbiguityInLayout) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(nextButton,cancelButton,deleteButton);
    
//    NSArray *constraints = [NSLayoutConstraint
//                            constraintsWithVisualFormat:@"|-[deleteButton]"
//                            options:0
//                            metrics:nil views:viewsDictionary];
//
//    [self.view addConstraints:constraints];
    
//    constraints = [NSLayoutConstraint
//                   constraintsWithVisualFormat:@"V:[deleteButton]-|"
//                   options:0
//                   metrics:nil views:viewsDictionary];
//  
//    [self.view addConstraints:constraints];
    
    
    // |-5-[deleteButton]-(>=8)-[cancelButton]-30-[nextButton]-|
    // |-[deleteButton]-(>=8)-[cancelButton]-[nextButton]-|
    NSArray *constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"|-[deleteButton(==nextButton@700)]-(>=8)-[cancelButton(==nextButton@700)]-[nextButton]-|"
                   options:NSLayoutFormatAlignAllBaseline
                   metrics:nil
                   views:viewsDictionary];
    NSLog(@"horizontal constraints is %@",constraints);
    [self.view addConstraints:constraints];
    
    constraints = [NSLayoutConstraint
                   constraintsWithVisualFormat:@"V:[nextButton]-|"
                   options:0
                   metrics:nil
                   views:viewsDictionary];
    [self.view addConstraints:constraints];
    
    // set the content Hugging priority
    [deleteButton setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    
    
//    constraints = [NSLayoutConstraint
//                   constraintsWithVisualFormat:@"V:[cancelButton]-|"
//                   options:0
//                   metrics:nil
//                   views:viewsDictionary];
//    [self.view addConstraints:constraints];
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
