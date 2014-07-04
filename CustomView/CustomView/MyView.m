//
//  MyView.m
//  CustomView
//
//  Created by Perry on 14-7-4.
//  Copyright (c) 2014年 Perrychen. All rights reserved.
//

#import "MyView.h"

@implementation MyView
{
    CGSize mySize;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        mySize = CGSizeMake(30, 30);
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(viewTapped:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

- (CGSize)intrinsicContentSize
{
    return mySize;
}

- (UIEdgeInsets)alignmentRectInsets
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)updateConstraints
{
    
}

- (void)viewTapped:(UITapGestureRecognizer *)recognizer
{
    mySize.width += 30.0f;
    mySize.height += 30.0f;
    [self invalidateIntrinsicContentSize];
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[UIColor redColor] setFill];
    CGRect alignmentRect = [self alignmentRectForFrame:self.bounds];
    UIRectFill(alignmentRect);
    NSLog(@"Alignment rect: %@",NSStringFromCGRect(alignmentRect));
}


@end
