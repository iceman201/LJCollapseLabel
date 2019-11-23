//
//  LJViewController.mm
//  LJCollapseLabel
//
//  Created by Liguo Jiao on 12/07/2018.
//  Copyright (c) 2018 Liguo Jiao. All rights reserved.
//

#import "LJViewController.h"
#import <LJCollapseLabel/CollapseLabel.h>
#include <string>
#include <iostream>

@interface LJViewController()
@property (weak, nonatomic) IBOutlet LJCollapseLabel *collapseLabel;
@end

@implementation LJViewController
{
    std::string _testContent;
}

- (void)loadView
{
    [super loadView];
    _testContent = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.";

    self.collapseLabel.isCollapsed = YES;
    self.collapseLabel.text = [NSString stringWithCString:_testContent.c_str() encoding:NSUTF8StringEncoding];
    self.collapseLabel.minimumHeight = 50;
    self.collapseLabel.textHeightChangedCallback = ^{
//        You can do your stuff here, i.e. event tracking, data collection
    };
#ifdef Debug
    [self.collapseLabel.layer setBorderColor:[[UIColor blueColor] CGColor]];
    [self.collapseLabel.layer setBorderWidth:1];
#endif
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
