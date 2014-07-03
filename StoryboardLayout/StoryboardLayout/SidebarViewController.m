//
//  SidebarViewController.m
//  StoryboardLayout
//
//  Created by Perry on 14-7-3.
//  Copyright (c) 2014年 Perrychen. All rights reserved.
//

#import "SidebarViewController.h"

@interface SidebarViewController()

- (IBAction)buttonTapped:(id)sender;

@end

@implementation SidebarViewController

- (IBAction)buttonTapped:(id)sender
{
    [sender exerciseAmbiguityInLayout];
}

@end
