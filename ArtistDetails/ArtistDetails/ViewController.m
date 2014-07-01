//
//  ViewController.m
//  ArtistDetails
//
//  Created by Perry on 14-7-1.
//  Copyright (c) 2014年 Perrychen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseYearLabel;
- (IBAction)nextButtonTapped:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)nextButtonTapped:(id)sender
{
    static NSArray *artists;
    if (artists == nil) {
        artists = @[@"Thelonious Monk", @"Miles Davis", @"Louis Jordan & His Tympany Five", @"Charlie 'Bird' Parder", @"Chet Baker"];
    }
    static int index = 0;
    self.artistNameLabel.text = artists[index % 5];
    static NSArray *texts;
    if (texts == nil) {
        texts = @[@"Year", @"Very Long Label Text:", @"Release Year:"];
    }
    self.releaseYearLabel.text = texts[index % 3];
    index ++ ;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
