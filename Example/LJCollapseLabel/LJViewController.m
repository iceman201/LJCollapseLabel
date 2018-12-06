//
//  LJViewController.m
//  LJCollapseLabel
//
//  Created by iceman201 on 12/07/2018.
//  Copyright (c) 2018 iceman201. All rights reserved.
//

#import "LJViewController.h"
#import <LJCollapseLabel/CollapseLabel.h>

@interface LJViewController ()
@property (weak, nonatomic) IBOutlet LJCollapseLabel *collapseLabel;

@end

@implementation LJViewController

- (void)loadView
{
    [super loadView];
    _collapseLabel.isCollapsed = YES;
    _collapseLabel.text = @"There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.";
    _collapseLabel.minimumHeight = 50;
    _collapseLabel.textHeightChangedCallback = ^{
//        You can do your stuff here, i.e. event tracking, data collection
    };

#ifdef DEBUG
    [_collapseLabel.layer setBorderColor:[[UIColor blueColor] CGColor]];
    [_collapseLabel.layer setBorderWidth:1];
#endif
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
